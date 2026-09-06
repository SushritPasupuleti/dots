#!/usr/bin/env bash
set -Eeuo pipefail

# Fix stale k3s endpoint references that may still point at a dead host like
# https://192.168.1.10:6443.
#
# This script is intentionally conservative: it updates or creates the active
# k3s server URL without stripping unrelated token configuration.
#
# Usage:
#   sudo K3S_TARGET_IP=192.168.1.207 ./scripts/k3s-fix-stale-endpoint.sh
#   sudo K3S_TARGET_IP=192.168.1.207 K3S_SERVER_URL=https://192.168.1.207:6443 ./scripts/k3s-fix-stale-endpoint.sh
#
# The script will:
#   - detect the current host IP if K3S_TARGET_IP is not provided
#   - rewrite any stale K3S_URL/server entries pointing at the dead address
#   - write a systemd override so the fixed endpoint is reused on restart
#   - reload/restart the k3s service when the unit exists

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script must be run as root (or with sudo)." >&2
  exit 1
fi

STALE_URL="${STALE_URL:-https://192.168.1.10:6443}"
K3S_TARGET_IP="${K3S_TARGET_IP:-}"
K3S_SERVER_URL="${K3S_SERVER_URL:-}"
K3S_CONFIG_PATH="${K3S_CONFIG_PATH:-/etc/rancher/k3s/config.yaml}"

if [[ -z "$K3S_TARGET_IP" ]]; then
  K3S_TARGET_IP="$(hostname -I 2>/dev/null | awk '{print $1}' || true)"
fi

if [[ -z "$K3S_TARGET_IP" ]]; then
  K3S_TARGET_IP="$(ip route get 1.1.1.1 2>/dev/null | awk 'NR==1 {print $NF}' || true)"
fi

if [[ -z "$K3S_TARGET_IP" ]]; then
  echo "Unable to determine the current LAN IP. Set K3S_TARGET_IP or K3S_SERVER_URL explicitly." >&2
  exit 1
fi

if [[ -z "$K3S_SERVER_URL" ]]; then
  K3S_SERVER_URL="https://${K3S_TARGET_IP}:6443"
fi

echo "Using k3s server URL: ${K3S_SERVER_URL}"

mkdir -p /etc/rancher/k3s /etc/systemd/system/k3s.service.d

backup_root="$(mktemp -d /tmp/k3s-fix.XXXXXX)"
cleanup() {
  rm -rf "$backup_root"
}
trap cleanup EXIT

if [[ -f "$K3S_CONFIG_PATH" ]]; then
  cp "$K3S_CONFIG_PATH" "$backup_root/config.yaml"
fi

# Rewrite the main k3s config if it still points at the stale node.
if [[ -f "$K3S_CONFIG_PATH" ]]; then
  awk -v stale="$STALE_URL" -v new_url="$K3S_SERVER_URL" '
    BEGIN { saw_server = 0 }
    {
      if ($0 ~ /^server:/) {
        print "server: " new_url
        saw_server = 1
        next
      }
      if ($0 ~ /^server =/ || $0 ~ /^K3S_URL=/ || $0 ~ /^K3S_SERVER=/) {
        print "K3S_URL=" new_url
        next
      }
      if ($0 ~ stale || $0 ~ /192\.168\.1\.10/ || $0 ~ /https:\/\/[^[:space:]]*:[0-9]+/) {
        # Preserve unrelated config lines; only clear stale server references.
        if ($0 ~ /server[[:space:]]*:/ || $0 ~ /K3S_URL=/ || $0 ~ /K3S_SERVER=/) {
          if ($0 ~ /server[[:space:]]*:/) {
            print "server: " new_url
          } else {
            print "K3S_URL=" new_url
          }
          next
        }
      }
      print
    }
    END {
      if (!saw_server) {
        print "server: " new_url
      }
    }
  ' "$K3S_CONFIG_PATH" > "$K3S_CONFIG_PATH.tmp" && mv "$K3S_CONFIG_PATH.tmp" "$K3S_CONFIG_PATH"
else
  printf 'server: %s\n' "$K3S_SERVER_URL" > "$K3S_CONFIG_PATH"
fi

# Rewrite any environment files that still set the stale URL.
for env_file in /etc/default/k3s /etc/rancher/k3s/config.env /etc/environment; do
  if [[ ! -f "$env_file" ]]; then
    continue
  fi
  cp "$env_file" "$backup_root/$(basename "$env_file")"
  awk -v stale="$STALE_URL" -v new_url="$K3S_SERVER_URL" '
    {
      if ($0 ~ /^K3S_URL=/ || $0 ~ /^K3S_SERVER=/) {
        print "K3S_URL=" new_url
        next
      }
      if ($0 ~ stale || $0 ~ /192\.168\.1\.10/) {
        next
      }
      print
    }
  ' "$env_file" > "$env_file.tmp" && mv "$env_file.tmp" "$env_file"
  if ! grep -Eq '^K3S_URL=' "$env_file" 2>/dev/null; then
    printf 'K3S_URL=%s\n' "$K3S_SERVER_URL" >> "$env_file"
  fi
done

# Create a dedicated override so the fix survives service restarts.
cat > /etc/systemd/system/k3s.service.d/99-k3s-fix-endpoint.conf <<EOF
[Service]
Environment=K3S_URL=$K3S_SERVER_URL
EOF

# Remove stale references from any service drop-ins.
for dropin in /etc/systemd/system/k3s.service.d/*.conf; do
  if [[ "$dropin" == "/etc/systemd/system/k3s.service.d/99-k3s-fix-endpoint.conf" ]]; then
    continue
  fi
  if grep -Eq 'K3S_URL=.*192\.168\.1\.10|server:.*192\.168\.1\.10|K3S_URL=.*https://192\.168\.1\.10' "$dropin" 2>/dev/null; then
    awk -v new_url="$K3S_SERVER_URL" '
      {
        if ($0 ~ /K3S_URL=/ || $0 ~ /K3S_SERVER=/ || $0 ~ /^[[:space:]]*server:/) {
          if ($0 ~ /K3S_URL=/ || $0 ~ /K3S_SERVER=/) {
            print "Environment=K3S_URL=" new_url
          } else {
            print "Environment=K3S_URL=" new_url
          }
          next
        }
        print
      }
    ' "$dropin" > "$dropin.tmp" && mv "$dropin.tmp" "$dropin"
  fi
done

systemctl daemon-reload 2>/dev/null || true

if systemctl list-unit-files k3s.service >/dev/null 2>&1; then
  echo "Restarting k3s to apply the corrected endpoint..."
  systemctl restart k3s || systemctl restart k3s.service || true
  systemctl status k3s --no-pager -l || true
else
  echo "k3s.service is not installed; the config files were updated but no restart was attempted."
fi

echo "Fixed k3s server URL to ${K3S_SERVER_URL}"
