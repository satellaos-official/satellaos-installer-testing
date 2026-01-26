#!/bin/bash

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
# 09 - Configure LightDM display manager
# --------------------------------------------------
echo "09 - Configuring LightDM..."
chmod +x "$HOME/satellaos-installer/lightdm/lightdm.sh"
"$HOME/satellaos-installer/lightdm/lightdm.sh"

# --------------------------------------------------
# 10 - Apply GRUB icon configuration
# --------------------------------------------------
echo "10 - Applying GRUB icon configuration..."
chmod +x "$HOME/satellaos-installer/grub-icon/grub-icon.sh"
"$HOME/satellaos-installer/grub-icon/grub-icon.sh"

# --------------------------------------------------
# 11 - Configure GRUB bootloader
# --------------------------------------------------
echo "11 - Configuring GRUB bootloader..."
chmod +x "$HOME/satellaos-installer/grub/grub.sh"
"$HOME/satellaos-installer/grub/grub.sh"

# --------------------------------------------------
# 12 - Touchpad configuration (tap-to-click)
# --------------------------------------------------
echo "12 - Applying touchpad configuration..."
chmod +x "$HOME/satellaos-installer/drivers/touchpad setup.sh"
"$HOME/satellaos-installer/drivers/touchpad setup.sh"

# --------------------------------------------------
# 13 - Bluetooth setup
# --------------------------------------------------
echo "13 - Installing and configuring Bluetooth..."
chmod +x "$HOME/satellaos-installer/drivers/bluetooth setup.sh"
"$HOME/satellaos-installer/drivers/bluetooth setup.sh"

# --------------------------------------------------
# 14 - AMD graphics stack setup (optional)
# --------------------------------------------------
echo "14 - Running AMD graphics setup (optional)..."
chmod +x "$HOME/satellaos-installer/drivers/graphics amd setup.sh"
"$HOME/satellaos-installer/drivers/graphics amd setup.sh"

# --------------------------------------------------
# 15 - Intel graphics stack setup (optional)
# --------------------------------------------------
echo "15 - Running Intel graphics setup (optional)..."
chmod +x "$HOME/satellaos-installer/drivers/graphics intel setup.sh"
"$HOME/satellaos-installer/drivers/graphics intel setup.sh"

# --------------------------------------------------
# 16 - Apply system configuration files
# --------------------------------------------------
echo "16 - Applying system configuration..."
chmod +x "$HOME/satellaos-installer/config/config.sh"
"$HOME/satellaos-installer/config/config.sh"

# --------------------------------------------------
# 17 - Install wallpapers and backgrounds
# --------------------------------------------------
echo "17 - Installing wallpapers and backgrounds..."
chmod +x "$HOME/satellaos-installer/backgrounds/backgrounds.sh"
"$HOME/satellaos-installer/backgrounds/backgrounds.sh"

# --------------------------------------------------
# 18 - Apply application icons
# --------------------------------------------------
echo "18 - Applying application icons..."
chmod +x "$HOME/satellaos-installer/application-icon/application-icon.sh"
"$HOME/satellaos-installer/application-icon/application-icon.sh"

# --------------------------------------------------
# 19 - Apply interface customizations
# --------------------------------------------------
echo "19 - Applying interface customizations..."
chmod +x "$HOME/satellaos-installer/interfaces/interfaces.sh"
"$HOME/satellaos-installer/interfaces/interfaces.sh"

# --------------------------------------------------
# 20 - Install and configure Fastfetch
# --------------------------------------------------
echo "20 - Installing Fastfetch..."
chmod +x "$HOME/satellaos-installer/fastfetch/fastfetch.sh"
"$HOME/satellaos-installer/fastfetch/fastfetch.sh"

# --------------------------------------------------
# 21 - Apply final system configuration
# --------------------------------------------------
echo "21 - Applying final configuration..."
chmod +x "$HOME/satellaos-installer/config-restore.sh"
"$HOME/satellaos-installer/config-restore.sh"

# --------------------------------------------------
# 22 - Program install
# --------------------------------------------------
echo "22 - Programs is installing..."
chmod +x "$HOME/satellaos-installer/satellaos-program-installer-tool-5.2.0.sh"
"$HOME/satellaos-installer/satellaos-program-installer-tool-5.2.0.sh"

echo "SatellaOS installation steps completed."
