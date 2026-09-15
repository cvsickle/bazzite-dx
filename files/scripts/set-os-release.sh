#!/usr/bin/env bash
set -euo pipefail

CURRENT_DATE="$(TZ=America/New_York date +'%Y%m%d')"

# Helper: set or replace a KEY=value line in /etc/os-release
set_os_release_var() {
  local key="$1" value="$2" file="/usr/lib/os-release"
  if grep -q "^${key}=" "$file"; then
    sed -i "s|^${key}=.*|${key}=\"${value}\"|" "$file"
  else
    echo "${key}=\"${value}\"" >> "$file"
  fi
}

set_os_release_var "NAME" "CVSickle Bazzite DX"
set_os_release_var "VERSION" "${CURRENT_DATE}"
set_os_release_var "PRETTY_NAME" "CVSickle Bazzite DX (${CURRENT_DATE})"

echo "Updated os-release:"
cat /usr/lib/os-release
