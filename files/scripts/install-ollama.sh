#!/usr/bin/env bash

set -euo pipefail

# Manual install from https://docs.ollama.com/linux
readonly release_url="https://ollama.com/download/ollama-linux-amd64.tar.zst"
temp_dir="$(mktemp -d)"

cleanup() {
	rm -rf "$temp_dir"
}

trap cleanup EXIT

curl --fail --silent --show-error --location --retry 3 \
	--output "$temp_dir/ollama-linux-amd64.tar.zst" \
	"$release_url"

# Extracts bin/ollama into /usr/bin and libraries into /usr/lib/ollama.
tar --extract --zstd --file "$temp_dir/ollama-linux-amd64.tar.zst" \
	--directory /usr
