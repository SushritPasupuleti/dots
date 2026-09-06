#!/usr/bin/env bash
set -Eeuo pipefail

# Diagnostic helper for the stale k3s endpoint issue.
#
# Usage:
#   sudo ./scripts/k3s-check.sh

printf '%s\n' '== k3s systemd unit ==' 
if command -v systemctl >/dev/null 2>&1; then
  systemctl cat k3s 2>/dev/null | sed -n '1,220p' || echo 'no k3s unit found'
  printf '\n%s\n' '== k3s environment ==' 
  systemctl show k3s -p Environment --value 2>/dev/null || true
else
  echo 'systemctl is not available on this host.'
fi

printf '\n%s\n' '== k3s config files ==' 
ls -la /etc/rancher/k3s 2>/dev/null || echo 'no /etc/rancher/k3s'
if [[ -f /etc/rancher/k3s/config.yaml ]]; then
  printf '\n%s\n' '== /etc/rancher/k3s/config.yaml ==' 
  sed -n '1,220p' /etc/rancher/k3s/config.yaml
fi

printf '\n%s\n' '== stale endpoint references ==' 
grep -RInE '192\.168\.1\.10|K3S_URL|K3S_TOKEN|--server|server:' /etc /var/lib /usr/local 2>/dev/null | head -n 150 || echo 'no matches found'

printf '\n%s\n' '== routes ==' 
ip route 2>/dev/null || echo 'ip route not available'

printf '\n%s\n' '== ping stale address ==' 
ping -c 2 192.168.1.10 2>&1 || true

printf '\n%s\n' '== k3s status ==' 
if command -v systemctl >/dev/null 2>&1; then
  systemctl status k3s --no-pager -l 2>/dev/null || echo 'k3s service not running or not installed'
fi

printf '\n%s\n' '== kubectl nodes ==' 
if command -v kubectl >/dev/null 2>&1; then
  kubectl get nodes 2>/dev/null || echo 'kubectl not connected or cluster is down'
fi
