#!/usr/bin/env bash

set -euo pipefail

cp /usr/share/k3s-setup/containerd-nvidia.toml.tmpl \
   /var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl

nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml || true

touch /var/lib/rancher/k3s/.nvidia-staged