#!/usr/bin/env bash
set -euo pipefail

K3S_KUBECONFIG="/etc/rancher/k3s/k3s.yaml"

if [ -f "$K3S_KUBECONFIG" ]; then
  chown root:wheel "$K3S_KUBECONFIG"
  chmod 640 "$K3S_KUBECONFIG"
  echo "Fixed K3s kubeconfig permissions: $K3S_KUBECONFIG"
else
  echo "K3s kubeconfig not found at $K3S_KUBECONFIG" >&2
  exit 1
fi
