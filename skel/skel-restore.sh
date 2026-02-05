#!/bin/bash

# Source and destination directories
SOURCE_DIR="$HOME/satellaos-installer/skel/"
DEST_DIR="/etc/skel/"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Copy files while excluding .sh scripts
rsync -a --delete --exclude="*.sh" "$SOURCE_DIR" "$DEST_DIR"

# Set ownership to root
chown -R root:root "$DEST_DIR"

echo "Reverse copy completed successfully."
echo ".sh files were ignored."
echo "All files are now owned by root."
