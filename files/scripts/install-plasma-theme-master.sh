#!/usr/bin/env bash

set -euo pipefail

# Build and install https://github.com/SonOfMithras/plasma-theme-master
# Build dependencies are provided by recipes/common/packages.yml.
# renovate: datasource=github-releases depName=SonOfMithras/plasma-theme-master
PLASMA_THEME_MASTER_VERSION="2.1.0"
readonly release_url="https://github.com/SonOfMithras/plasma-theme-master/archive/refs/tags/v${PLASMA_THEME_MASTER_VERSION}.tar.gz"
readonly prefix="/usr"
temp_dir="$(mktemp -d)"

cleanup() {
	rm -rf "$temp_dir"
}

trap cleanup EXIT

curl --fail --silent --show-error --location --retry 3 \
	--output "$temp_dir/plasma-theme-master.tar.gz" \
	"$release_url"

tar --extract --gzip --file "$temp_dir/plasma-theme-master.tar.gz" \
	--strip-components=1 \
	--directory "$temp_dir"

cmake -S "$temp_dir" -B "$temp_dir/build" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX="$prefix"
cmake --build "$temp_dir/build" --parallel "$(nproc)"
cmake --install "$temp_dir/build"

# Desktop entry so the GUI shows up in the application menu.
install --directory "$prefix/share/applications"
install --mode=0644 "$temp_dir/plasma-theme-master.desktop" \
	"$prefix/share/applications/plasma-theme-master.desktop"
