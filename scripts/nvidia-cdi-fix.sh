#!/usr/bin/env bash
set -Eeuo pipefail

# NVIDIA CDI / containerd repair for k3s nodes.
# This is meant to be run on the host after a rebuild or when the GPU plugin
# reports that no devices were found and /etc/cdi is missing.

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script must be run as root (or with sudo)." >&2
  exit 1
fi

mkdir -p /etc/cdi

if ! command -v nvidia-ctk >/dev/null 2>&1; then
  echo "nvidia-ctk is not installed. Ensure hardware.nvidia-container-toolkit.enable = true." >&2
  exit 1
fi

nvidia-ctk runtime configure \
  --runtime=containerd \
  --set-as-default \
  --enable-cdi

nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
chmod 0644 /etc/cdi/nvidia.yaml

if systemctl list-unit-files containerd.service >/dev/null 2>&1; then
  systemctl restart containerd || true
fi

if systemctl list-unit-files k3s.service >/dev/null 2>&1; then
  systemctl restart k3s || true
fi

ls -la /etc/cdi

printf '\nGenerated CDI spec:\n'
sed -n '1,160p' /etc/cdi/nvidia.yaml 2>/dev/null || true
