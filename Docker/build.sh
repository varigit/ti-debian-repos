#!/bin/bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

IMAGE_NAME="debian-arm64-build"
DEB_SUITE="${DEB_SUITE:-trixie}"

BINFMT_IMAGE="tonistiigi/binfmt:qemu-v10.2.3-68@sha256:400a4873b838d1b89194d982c45e5fb3cda4593fbfd7e08a02e76b03b21166f0"

echo "Installing ARM64 binfmt support..."
docker run --privileged --rm \
    "${BINFMT_IMAGE}" \
    --install arm64

echo "Building ARM64 Debian image..."
docker build \
    --platform linux/arm64 \
    --build-arg DEB_SUITE="${DEB_SUITE}" \
    -t "${IMAGE_NAME}:${DEB_SUITE}" \
    "${SCRIPT_DIR}"

echo
echo "Image created:"
docker image inspect \
    "${IMAGE_NAME}:${DEB_SUITE}" \
    --format '{{.RepoTags}} {{.Architecture}}'
