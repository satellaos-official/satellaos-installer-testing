#!/bin/bash

# ==========================================
# SatellaOS Installer with Silent Background Logging
# Version 13 (Trixie)
# ==========================================

# Log Configuration (Silent - runs in background)
LOG_DIR="$HOME/satellaos-installer/logs"
LOG_FILE="$LOG_DIR/installation_$(date +%Y%m%d_%H%M%S).log"
mkdir -p "$LOG_DIR"

# Silent logging function - only writes to file, not terminal
silent_log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${level}] ${timestamp} - ${message}" >> "$LOG_FILE"
}

# Function to execute script with silent logging
execute_script_silent() {
    local script_path="$1"
    local step_name="$2"
    
    silent_log "INFO" "Making script executable: $script_path"
    chmod +x "$script_path" 2>> "$LOG_FILE"
    
    silent_log "INFO" "Executing: $script_path"
    if "$script_path" 2>> "$LOG_FILE"; then
        silent_log "SUCCESS" "$step_name completed successfully"
        return 0
    else
        silent_log "ERROR" "$step_name failed with exit code: $?"
        return 1
    fi
}

# ==========================================
# START INSTALLATION
# ==========================================

silent_log "INFO" "SatellaOS Installer Version 13 (Trixie) started"
silent_log "INFO" "Log file created at: $LOG_FILE"

echo "Version 13 (Trixie)"

# Ask the user if they want to start the installation
read -p "Do you want to start the SatellaOS installation? [Y/N]: " choice

silent_log "INFO" "User input received: $choice"

# Convert the input to lowercase and check
case "${choice,,}" in
    y|yes)
        silent_log "SUCCESS" "Installation confirmed by user"
        echo "Starting SatellaOS installation..."
        ;;
    n|no)
        silent_log "WARNING" "Installation canceled by user"
        echo "Installation canceled."
        exit 0
        ;;
    *)
        silent_log "ERROR" "Invalid user input: $choice"
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# ==========================================
# INSTALLATION STEPS
# ==========================================

# --------------------------------------------------
# 00 - Install required base tools
# --------------------------------------------------
silent_log "STEP" "00 - Installing required base tools (curl, wget)"
echo "00 - Installing required base tools (curl, wget)..."
sudo apt install --no-install-recommends -y curl wget 2>> "$LOG_FILE" | grep -v "^Reading\|^Building\|^The following\|^0 upgraded"
silent_log "SUCCESS" "Base tools installation completed"

# --------------------------------------------------
# 01 - Install and ensure network connectivity
# --------------------------------------------------
silent_log "STEP" "01 - Installing network components"
echo "01 - Installing network components (required for installer)..."
execute_script_silent "$HOME/satellaos-installer/network/network.sh" "Network setup"

# --------------------------------------------------
# 02 - Enable and run APT sources configuration
# --------------------------------------------------
silent_log "STEP" "02 - Configuring APT sources"
echo "02 - Configuring APT sources..."
execute_script_silent "$HOME/satellaos-installer/sources/sources.sh" "APT sources configuration"

# --------------------------------------------------
# 03 - Run core desktop and base system setup
# --------------------------------------------------
silent_log "STEP" "03 - Running core desktop and base system setup"
echo "03 - Running core desktop and base system setup..."
execute_script_silent "$HOME/satellaos-installer/core/core.sh" "Core system setup"

# --------------------------------------------------
# 04 - Apply Papirus Violet icon theme
# --------------------------------------------------
silent_log "STEP" "04 - Applying Papirus Violet icon theme"
echo "04 - Applying Papirus Violet icon theme..."
execute_script_silent "$HOME/satellaos-installer/themes/papirus-violet.sh" "Papirus Violet theme"

# --------------------------------------------------
# 05 - Apply Fluent GTK theme
# --------------------------------------------------
silent_log "STEP" "05 - Applying Fluent GTK theme"
echo "05 - Applying Fluent GTK theme..."
execute_script_silent "$HOME/satellaos-installer/themes/Fluent-gtk-theme.sh" "Fluent GTK theme"

# --------------------------------------------------
# 06 - Configure sudo permissions for user
# --------------------------------------------------
silent_log "STEP" "06 - Configuring sudo permissions"
echo "06 - Configuring sudo permissions..."
execute_script_silent "$HOME/satellaos-installer/sudo-permissions/adduser.sh" "Sudo permissions"

# --------------------------------------------------
# 07 - Configure OS release information
# --------------------------------------------------
silent_log "STEP" "07 - Setting OS release information"
echo "07 - Setting OS release information..."
execute_script_silent "$HOME/satellaos-installer/os-release/os-release.sh" "OS release configuration"

# --------------------------------------------------
# 08 - Apply SatellaOS system logo
# --------------------------------------------------
silent_log "STEP" "08 - Applying SatellaOS system logo"
echo "08 - Applying SatellaOS system logo..."
execute_script_silent "$HOME/satellaos-installer/logo/logo.sh" "System logo"

# --------------------------------------------------
# 09 - Apply GRUB icon configuration
# --------------------------------------------------
silent_log "STEP" "09 - Applying GRUB icon configuration"
echo "09 - Applying GRUB icon configuration..."
execute_script_silent "$HOME/satellaos-installer/grub-icon/grub-icon.sh" "GRUB icon"

# --------------------------------------------------
# 10 - Configure GRUB bootloader
# --------------------------------------------------
silent_log "STEP" "10 - Configuring GRUB bootloader"
echo "10 - Configuring GRUB bootloader..."
execute_script_silent "$HOME/satellaos-installer/grub/grub.sh" "GRUB bootloader"

# --------------------------------------------------
# 11 - Touchpad configuration (tap-to-click)
# --------------------------------------------------
silent_log "STEP" "11 - Applying touchpad configuration"
echo "11 - Applying touchpad configuration..."
execute_script_silent "$HOME/satellaos-installer/drivers/touchpad-setup.sh" "Touchpad setup"

# --------------------------------------------------
# 12 - Bluetooth setup
# --------------------------------------------------
silent_log "STEP" "12 - Installing and configuring Bluetooth"
echo "12 - Installing and configuring Bluetooth..."
execute_script_silent "$HOME/satellaos-installer/drivers/bluetooth-setup.sh" "Bluetooth setup"

# --------------------------------------------------
# 13 - AMD graphics stack setup (optional)
# --------------------------------------------------
silent_log "STEP" "13 - Running AMD graphics setup (optional)"
echo "13 - Running AMD graphics setup (optional)..."
execute_script_silent "$HOME/satellaos-installer/drivers/graphics-amd-setup.sh" "AMD graphics setup"

# --------------------------------------------------
# 14 - Intel graphics stack setup (optional)
# --------------------------------------------------
silent_log "STEP" "14 - Running Intel graphics setup (optional)"
echo "14 - Running Intel graphics setup (optional)..."
execute_script_silent "$HOME/satellaos-installer/drivers/graphics-intel-setup.sh" "Intel graphics setup"

# --------------------------------------------------
# 15 - Install wallpapers and backgrounds
# --------------------------------------------------
silent_log "STEP" "15 - Installing wallpapers and backgrounds"
echo "15 - Installing wallpapers and backgrounds..."
execute_script_silent "$HOME/satellaos-installer/backgrounds/backgrounds.sh" "Wallpapers installation"

# --------------------------------------------------
# 16 - Apply application icons
# --------------------------------------------------
silent_log "STEP" "16 - Applying application icons"
echo "16 - Applying application icons..."
execute_script_silent "$HOME/satellaos-installer/application-icon/application-icon.sh" "Application icons"

# --------------------------------------------------
# 17 - Apply interface customizations
# --------------------------------------------------
silent_log "STEP" "17 - Applying interface customizations"
echo "17 - Applying interface customizations..."
execute_script_silent "$HOME/satellaos-installer/interfaces/interfaces.sh" "Interface customizations"

# --------------------------------------------------
# 18 - Install and configure Fastfetch
# --------------------------------------------------
silent_log "STEP" "18 - Installing Fastfetch"
echo "18 - Installing Fastfetch..."
execute_script_silent "$HOME/satellaos-installer/fastfetch/fastfetch.sh" "Fastfetch installation"

# --------------------------------------------------
# 19 - Fonts Installer
# --------------------------------------------------
silent_log "STEP" "19 - Installing fonts"
echo "19 - Installing fonts..."
execute_script_silent "$HOME/satellaos-installer/fonts/fonts.sh" "Fonts installation"

# --------------------------------------------------
# 20 - Program install
# --------------------------------------------------
silent_log "STEP" "20 - Installing programs"
echo "20 - Installing programs..."
execute_script_silent "$HOME/satellaos-installer/satellaos-program-installer-tool.sh" "Programs installation"

# --------------------------------------------------
# 21 - Restore configuration to /etc/skel
# --------------------------------------------------
silent_log "STEP" "21 - Restoring pre-saved configuration to /etc/skel"
echo "21 - Restoring pre-saved configuration to /etc/skel..."
execute_script_silent "$HOME/satellaos-installer/skel/skel-restore.sh" "Skel restore"

# --------------------------------------------------
# 22 - Configure quiet console settings
# --------------------------------------------------
silent_log "STEP" "22 - Configuring /etc/sysctl.d/99-quiet-console.conf"
echo "22 - Configuring /etc/sysctl.d/99-quiet-console.conf..."
execute_script_silent "$HOME/satellaos-installer/config-quiet/config-quiet.sh" "Quiet console configuration"

# --------------------------------------------------
# 23 - Apply final system configuration
# --------------------------------------------------
silent_log "STEP" "23 - Applying final configuration"
echo "23 - Applying final configuration..."
execute_script_silent "$HOME/satellaos-installer/config-restore.sh" "Final configuration"

# ==========================================
# INSTALLATION COMPLETE
# ==========================================

echo ""
echo "SatellaOS installation steps completed."
silent_log "SUCCESS" "SatellaOS installation completed successfully"
silent_log "INFO" "Installation log saved at: $LOG_FILE"