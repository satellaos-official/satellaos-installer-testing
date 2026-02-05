#!/bin/bash

# Backup script: /etc/skel → $HOME/satellaos-installer/skel/

# Ensure the destination directory exists
DEST_DIR="$HOME/satellaos-installer/skel/"
mkdir -p "$DEST_DIR"

# Source directory
SOURCE_DIR="/etc/skel/"

# Get current user and group
CURRENT_USER="$(id -u)"
CURRENT_GROUP="$(id -g)"

# Copy all contents from /etc/skel to destination
cp -a "$SOURCE_DIR." "$DEST_DIR"

# Change ownership to the current user
chown -R "$CURRENT_USER:$CURRENT_GROUP" "$DEST_DIR"

echo "Backup completed successfully."
echo "All files are now owned by the current user."
