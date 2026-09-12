#!/usr/bin/env bash

set -euo pipefail

install -d -m 0755 /var/lib/rancher/k3s/agent/etc/containerd
install -d -m 0755 /var/lib/rancher/k3s/server/manifests

cp /usr/share/k3s-setup/manifests/*.yaml \
   /var/lib/rancher/k3s/server/manifests/

touch /var/lib/rancher/k3s/.staged