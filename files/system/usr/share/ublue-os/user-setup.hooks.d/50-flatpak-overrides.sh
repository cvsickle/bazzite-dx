#!/usr/bin/env bash
set -euo pipefail

# General.
flatpak override --user \
  --filesystem="$HOME/.themes:ro" \
  --filesystem="$HOME/.local/share/themes:ro" \
  --filesystem="$HOME/.icons:ro" \
  --filesystem="$HOME/.local/share/icons:ro" \
  --filesystem=xdg-config/gtk-3.0:ro \
  --filesystem=xdg-config/gtk-4.0:ro \
  --filesystem=xdg-config/qt6ct:ro \
  --filesystem=xdg-config/kdeglobals:ro \
  --filesystem=xdg-data/color-schemes:ro \
  --device=dri
  
# Protontricks
flatpak override --user \
  --filesystem="$HOME/.local/share/Steam" \
  com.github.Matoking.protontricks