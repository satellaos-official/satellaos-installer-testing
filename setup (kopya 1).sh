#!/bin/bash

LOG_DIR="$HOME/satellaos-installer"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/install_$(date '+%Y-%m-%d_%H-%M-%S').log"

# stdout + stderr → log dosyası
exec >"$LOG_FILE" 2>&1

exec > >(while IFS= read -r line; do echo "[$(date '+%Y-%m-%d %H:%M:%S')] $line"; done | tee -a "$LOG_FILE") 2>&1

echo "Version 13 (Trixie)"
# Ask the user if they want to start the installation
read -p "Do you want to start the SatellaOS installation? [Y/N]: " choice

# Convert the input to lowercase and check
case "${choice,,}" in
    y|yes)
        echo "Starting SatellaOS installation..."
        ;;
    n|no)
        echo "Installation canceled."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# SatellaOS main installer execution script
# This script prepares and runs all SatellaOS installer components in order

# --------------------------------------------------
# 00 - Install required base tools
# --------------------------------------------------
echo "00 - Installing required base tools (curl, wget)..."
sudo apt install --no-install-recommends -y curl wget

# --------------------------------------------------
# 01 - Install and ensure network connectivity
# --------------------------------------------------
echo "01 - Installing network components (required for installer)..."
chmod +x "$HOME/satellaos-installer/network/network.sh"
"$HOME/satellaos-installer/network/network.sh"

# --------------------------------------------------
# 02 - Enable and run APT sources configuration
# --------------------------------------------------
echo "02 - Configuring APT sources..."
chmod +x "$HOME/satellaos-installer/sources/sources.sh"
"$HOME/satellaos-installer/sources/sources.sh"

# --------------------------------------------------
# 03 - Run core desktop and base system setup
# --------------------------------------------------
echo "03 - Running core desktop and base system setup..."
chmod +x "$HOME/satellaos-installer/core/core.sh"
"$HOME/satellaos-installer/core/core.sh"

# --------------------------------------------------
# 04 - Apply Papirus Violet icon theme
# --------------------------------------------------
echo "04 - Applying Papirus Violet icon theme..."
chmod +x "$HOME/satellaos-installer/themes/papirus-violet.sh"
"$HOME/satellaos-installer/themes/papirus-violet.sh"

# --------------------------------------------------
# 05 - Apply Fluent GTK theme
# --------------------------------------------------
echo "05 - Applying Fluent GTK theme..."
chmod +x "$HOME/satellaos-installer/themes/Fluent-gtk-theme.sh"
"$HOME/satellaos-installer/themes/Fluent-gtk-theme.sh"

# --------------------------------------------------
# 06 - Configure sudo permissions for user
# --------------------------------------------------
echo "06 - Configuring sudo permissions..."
chmod +x "$HOME/satellaos-installer/sudo-permissions/adduser.sh"
"$HOME/satellaos-installer/sudo-permissions/adduser.sh"

# --------------------------------------------------
# 07 - Configure OS release information
# --------------------------------------------------
echo "07 - Setting OS release information..."
chmod +x "$HOME/satellaos-installer/os-release/os-release.sh"
"$HOME/satellaos-installer/os-release/os-release.sh"

# --------------------------------------------------
# 08 - Apply SatellaOS system logo
# --------------------------------------------------
echo "08 - Applying SatellaOS system logo..."
chmod +x "$HOME/satellaos-installer/logo/logo.sh"
"$HOME/satellaos-installer/logo/logo.sh"

# --------------------------------------------------
# 09 - Apply GRUB icon configuration
# --------------------------------------------------
echo "09 - Applying GRUB icon configuration..."
chmod +x "$HOME/satellaos-installer/grub-icon/grub-icon.sh"
"$HOME/satellaos-installer/grub-icon/grub-icon.sh"

# --------------------------------------------------
# 10 - Configure GRUB bootloader
# --------------------------------------------------
echo "10 - Configuring GRUB bootloader..."
chmod +x "$HOME/satellaos-installer/grub/grub.sh"
"$HOME/satellaos-installer/grub/grub.sh"

# --------------------------------------------------
# 11 - Touchpad configuration (tap-to-click)
# --------------------------------------------------
echo "11 - Applying touchpad configuration..."
chmod +x "$HOME/satellaos-installer/drivers/touchpad-setup.sh"
"$HOME/satellaos-installer/drivers/touchpad-setup.sh"

# --------------------------------------------------
# 12 - Bluetooth setup
# --------------------------------------------------
echo "12 - Installing and configuring Bluetooth..."
chmod +x "$HOME/satellaos-installer/drivers/bluetooth-setup.sh"
"$HOME/satellaos-installer/drivers/bluetooth-setup.sh"

# --------------------------------------------------
# 13 - AMD graphics stack setup (optional)
# --------------------------------------------------
echo "13 - Running AMD graphics setup (optional)..."
chmod +x "$HOME/satellaos-installer/drivers/graphics-amd-setup.sh"
"$HOME/satellaos-installer/drivers/graphics-amd-setup.sh"

# --------------------------------------------------
# 14 - Intel graphics stack setup (optional)
# --------------------------------------------------
echo "14 - Running Intel graphics setup (optional)..."
chmod +x "$HOME/satellaos-installer/drivers/graphics-intel-setup.sh"
"$HOME/satellaos-installer/drivers/graphics-intel-setup.sh"

# --------------------------------------------------
# 15 - Install wallpapers and backgrounds
# --------------------------------------------------
echo "15 - Installing wallpapers and backgrounds..."
chmod +x "$HOME/satellaos-installer/backgrounds/backgrounds.sh"
"$HOME/satellaos-installer/backgrounds/backgrounds.sh"

# --------------------------------------------------
# 16 - Apply application icons
# --------------------------------------------------
echo "16 - Applying application icons..."
chmod +x "$HOME/satellaos-installer/application-icon/application-icon.sh"
"$HOME/satellaos-installer/application-icon/application-icon.sh"

# --------------------------------------------------
# 17 - Apply interface customizations
# --------------------------------------------------
echo "17 - Applying interface customizations..."
chmod +x "$HOME/satellaos-installer/interfaces/interfaces.sh"
"$HOME/satellaos-installer/interfaces/interfaces.sh"

# --------------------------------------------------
# 18 - Install and configure Fastfetch
# --------------------------------------------------
echo "18 - Installing Fastfetch..."
chmod +x "$HOME/satellaos-installer/fastfetch/fastfetch.sh"
"$HOME/satellaos-installer/fastfetch/fastfetch.sh"

# --------------------------------------------------
# 19 - Fonts Installer
# --------------------------------------------------
echo "19 - Installing fonts..."
chmod +x "$HOME/satellaos-installer/fonts/fonts.sh"
"$HOME/satellaos-installer/fonts/fonts.sh"

# --------------------------------------------------
# 20 - Program install
# --------------------------------------------------
echo "20 - Installing programs..."
chmod +x "$HOME/satellaos-installer/satellaos-program-installer-tool.sh"
"$HOME/satellaos-installer/satellaos-program-installer-tool.sh"

# --------------------------------------------------
# 21 - Restore configuration to /etc/skel
# --------------------------------------------------
echo "21 - Restoring pre-saved configuration to /etc/skel..."
chmod +x "$HOME/satellaos-installer/skel/skel-restore.sh"
"$HOME/satellaos-installer/skel/skel-restore.sh"

# --------------------------------------------------
# 22 - Configure quiet console settings
# --------------------------------------------------
echo "22 - Configuring /etc/sysctl.d/99-quiet-console.conf..."
chmod +x "$HOME/satellaos-installer/config-quiet/config-quiet.sh"
"$HOME/satellaos-installer/config-quiet/config-quiet.sh"

# --------------------------------------------------
# 23 - Apply final system configuration
# --------------------------------------------------
echo "23 - Applying final configuration..."
chmod +x "$HOME/satellaos-installer/config-restore.sh"
"$HOME/satellaos-installer/config-restore.sh"

echo "SatellaOS installation steps completed."
