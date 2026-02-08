#!/bin/bash

LOG_DIR="$HOME/satellaos-installer/LOG"
mkdir -p "$LOG_DIR"

run_script() {
    local script_path="$1"
    local script_name
    script_name="$(basename "$script_path" .sh)"
    local log_file="$LOG_DIR/${script_name}_$(date '+%Y-%m-%d_%H-%M-%S').log"

    chmod +x "$script_path"

    "$script_path" >"$log_file" 2>&1
}

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
run_script "$HOME/satellaos-installer/network/network.sh"

# --------------------------------------------------
# 02 - Enable and run APT sources configuration
# --------------------------------------------------
echo "02 - Configuring APT sources..."
run_script "$HOME/satellaos-installer/sources/sources.sh"

# --------------------------------------------------
# 03 - Run core desktop and base system setup
# --------------------------------------------------
echo "03 - Running core desktop and base system setup..."
run_script "$HOME/satellaos-installer/core/core.sh"

# --------------------------------------------------
# 04 - Apply Papirus Violet icon theme
# --------------------------------------------------
echo "04 - Applying Papirus Violet icon theme..."
run_script "$HOME/satellaos-installer/themes/papirus-violet.sh"

# --------------------------------------------------
# 05 - Apply Fluent GTK theme
# --------------------------------------------------
echo "05 - Applying Fluent GTK theme..."
run_script "$HOME/satellaos-installer/themes/Fluent-gtk-theme.sh"

# --------------------------------------------------
# 06 - Configure sudo permissions for user
# --------------------------------------------------
echo "06 - Configuring sudo permissions..."
run_script "$HOME/satellaos-installer/sudo-permissions/adduser.sh"

# --------------------------------------------------
# 07 - Configure OS release information
# --------------------------------------------------
echo "07 - Setting OS release information..."
run_script "$HOME/satellaos-installer/os-release/os-release.sh"

# --------------------------------------------------
# 08 - Apply SatellaOS system logo
# --------------------------------------------------
echo "08 - Applying SatellaOS system logo..."
run_script "$HOME/satellaos-installer/logo/logo.sh"

# --------------------------------------------------
# 09 - Apply GRUB icon configuration
# --------------------------------------------------
echo "09 - Applying GRUB icon configuration..."
run_script "$HOME/satellaos-installer/grub-icon/grub-icon.sh"

# --------------------------------------------------
# 10 - Configure GRUB bootloader
# --------------------------------------------------
echo "10 - Configuring GRUB bootloader..."
run_script "$HOME/satellaos-installer/grub/grub.sh"

# --------------------------------------------------
# 11 - Touchpad configuration (tap-to-click)
# --------------------------------------------------
echo "11 - Applying touchpad configuration..."
run_script "$HOME/satellaos-installer/drivers/touchpad-setup.sh"

# --------------------------------------------------
# 12 - Bluetooth setup
# --------------------------------------------------
echo "12 - Installing and configuring Bluetooth..."
run_script "$HOME/satellaos-installer/drivers/bluetooth-setup.sh"

# --------------------------------------------------
# 13 - AMD graphics stack setup (optional)
# --------------------------------------------------
echo "13 - Running AMD graphics setup (optional)..."
run_script "$HOME/satellaos-installer/drivers/graphics-amd-setup.sh"

# --------------------------------------------------
# 14 - Intel graphics stack setup (optional)
# --------------------------------------------------
echo "14 - Running Intel graphics setup (optional)..."
run_script "$HOME/satellaos-installer/drivers/graphics-intel-setup.sh"

# --------------------------------------------------
# 15 - Install wallpapers and backgrounds
# --------------------------------------------------
echo "15 - Installing wallpapers and backgrounds..."
run_script "$HOME/satellaos-installer/backgrounds/backgrounds.sh"

# --------------------------------------------------
# 16 - Apply application icons
# --------------------------------------------------
echo "16 - Applying application icons..."
run_script "$HOME/satellaos-installer/application-icon/application-icon.sh"

# --------------------------------------------------
# 17 - Apply interface customizations
# --------------------------------------------------
echo "17 - Applying interface customizations..."
run_script "$HOME/satellaos-installer/interfaces/interfaces.sh"

# --------------------------------------------------
# 18 - Install and configure Fastfetch
# --------------------------------------------------
echo "18 - Installing Fastfetch..."
run_script "$HOME/satellaos-installer/fastfetch/fastfetch.sh"

# --------------------------------------------------
# 19 - Fonts Installer
# --------------------------------------------------
echo "19 - Installing fonts..."
run_script "$HOME/satellaos-installer/fonts/fonts.sh"

# --------------------------------------------------
# 20 - Program install
# --------------------------------------------------
echo "20 - Installing programs..."
run_script "$HOME/satellaos-installer/satellaos-program-installer-tool.sh"

# --------------------------------------------------
# 21 - Restore configuration to /etc/skel
# --------------------------------------------------
echo "21 - Restoring pre-saved configuration to /etc/skel..."
run_script "$HOME/satellaos-installer/skel/skel-restore.sh"

# --------------------------------------------------
# 22 - Configure quiet console settings
# --------------------------------------------------
echo "22 - Configuring /etc/sysctl.d/99-quiet-console.conf..."
run_script "$HOME/satellaos-installer/config-quiet/config-quiet.sh"

# --------------------------------------------------
# 23 - Apply final system configuration
# --------------------------------------------------
echo "23 - Applying final configuration..."
run_script "$HOME/satellaos-installer/config-restore.sh"

echo "SatellaOS installation steps completed."
