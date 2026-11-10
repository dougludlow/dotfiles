#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

aspace_install_dir="${ASPACE_INSTALL_DIR:-$HOME/.local/bin}"
if [[ -x "$aspace_install_dir/aspace" ]]; then
  exit 0
fi

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "aspace's prebuilt CLI requires Apple silicon." >&2
  exit 1
fi

aspace_version="0.4.0"
aspace_sha256="21a645498417cb21e82efab1fafabd9ff424b7444611de9dd8a95fde17a55726"
aspace_tmp_dir="$(mktemp -d)"
trap 'rm -rf "$aspace_tmp_dir"' EXIT
aspace_archive="$aspace_tmp_dir/aspace.tar.gz"

curl --fail --location --silent --show-error \
  "https://github.com/asumaran/aspace/releases/download/v${aspace_version}/aspace-v${aspace_version}-darwin-arm64.tar.gz" \
  --output "$aspace_archive"
printf '%s  %s\n' "$aspace_sha256" "$aspace_archive" | shasum -a 256 -c -
tar -xzf "$aspace_archive" -C "$aspace_tmp_dir" aspace
install -d "$aspace_install_dir"
install -m 0755 "$aspace_tmp_dir/aspace" "$aspace_install_dir/aspace"
