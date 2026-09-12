#!/usr/bin/env bash

set -euo pipefail

K3S_VERSION="v1.31.4+k3s1"

curl -fsSL -o /usr/bin/k3s \
  "https://github.com/k3s-io/k3s/releases/download/${K3S_VERSION}/k3s"

chmod +x /usr/bin/k3s