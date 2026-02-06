#!/bin/bash
set -e

SOURCE="$HOME/satellaos-installer/config-quiet/99-quiet-console.conf"
TARGET="/etc/sysctl.d/99-quiet-console.conf"

echo "Configuring quiet console settings..."

if [ ! -f "$SOURCE" ]; then
  echo "ERROR: Config file not found: $SOURCE"
  exit 1
fi

sudo cp "$SOURCE" "$TARGET"
sudo sysctl --system
