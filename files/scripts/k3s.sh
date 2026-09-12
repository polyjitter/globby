#!/usr/bin/env bash

set -euo pipefail

K3S_VERSION="v1.31.4+k3s1"
RELEASE_URL="https://github.com/k3s-io/k3s/releases/download/${K3S_VERSION}"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT

curl -fsSL -o "${WORKDIR}/k3s" \
  "${RELEASE_URL}/k3s"

curl -fsSL -o "${WORKDIR}/sha256sum-amd64.txt" \
  "${RELEASE_URL}/sha256sum-amd64.txt"

( cd "${WORKDIR}" && grep -E '  k3s$' sha256sum-amd64.txt | sha256sum -c - )

install -m 0755 "${WORKDIR}/k3s" /usr/bin/k3s