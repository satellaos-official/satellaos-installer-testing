#!/bin/bash

set -e

BASE="$HOME/satellaos-installer/configuration"

#################################
# XFCE (USER)
#################################

if [ -d "$BASE/xfce/user/xfce4" ]; then
    echo "▶ Restoring XFCE (user)..."

    rm -rf "$HOME/.config/xfce4"
    cp -a "$BASE/xfce/user/xfce4" "$HOME/.config/"
fi

#################################
# XFCONF (USER)  ← KRİTİK
#################################

if [ -d "$BASE/xfce/xfconf/xfconf" ]; then
    echo "▶ Restoring XFCONF (user)..."

    rm -rf "$HOME/.config/xfconf"
    cp -a "$BASE/xfce/xfconf/xfconf" "$HOME/.config/"
fi

#################################
# THUNAR (USER)
#################################

if [ -d "$BASE/thunar/Thunar" ]; then
    echo "▶ Restoring Thunar configuration..."

    rm -rf "$HOME/.config/Thunar"
    cp -a "$BASE/thunar/Thunar" "$HOME/.config/"
fi

#################################
# AUTOSTART (USER)
#################################

if [ -d "$BASE/autostart/autostart" ]; then
    echo "▶ Restoring Autostart..."

    rm -rf "$HOME/.config/autostart"
    cp -a "$BASE/autostart/autostart" "$HOME/.config/"
fi

#################################
# XFCE (SYSTEM)
#################################

if [ -d "$BASE/xfce/system/xfce4" ]; then
    echo "▶ Restoring XFCE (system defaults)..."

    sudo rm -rf /etc/xdg/xfce4
    sudo cp -a "$BASE/xfce/system/xfce4" /etc/xdg/
fi

#################################
# LIGHTDM (SYSTEM)
#################################

if [ -d "$BASE/lightdm/config/lightdm" ]; then
    echo "▶ Restoring LightDM configuration..."

    sudo rm -rf /etc/lightdm
    sudo cp -a "$BASE/lightdm/config/lightdm" /etc/
fi

#################################
# SLICK GREETER
#################################

if [ -d "$BASE/lightdm/slick-greeter" ]; then
    echo "▶ Restoring Slick Greeter settings..."
    sudo cp -a "$BASE/lightdm/slick-greeter/"* /etc/lightdm/ 2>/dev/null || true
fi

#################################
# GREETER GTK (lightdm user)
#################################

if [ -d "$BASE/lightdm/gtk/.config" ]; then
    echo "▶ Restoring Greeter GTK settings..."

    sudo rm -rf /var/lib/lightdm/.config
    sudo cp -a "$BASE/lightdm/gtk/.config" /var/lib/lightdm/
    sudo chown -R lightdm:lightdm /var/lib/lightdm/.config
fi

#################################
# PERMISSION FIX (USER)
#################################

echo "▶ Fixing user permissions..."
chown -R "$USER:$USER" "$HOME/.config"

#################################
# LIGHTDM CACHE CLEANUP
#################################

sudo rm -rf /var/cache/lightdm/*
sudo rm -rf /var/lib/lightdm/.cache/*

#################################
# DONE
#################################

echo "✅ Restore completed successfully."
echo "🔁 Reboot is strongly recommended."

while true; do
    read -r -p "Do you want to restart the system? (Y/N): " answer
    case "$answer" in
        [Yy]* )
            echo "Restarting the system..."
            sudo reboot
            break
            ;;
        [Nn]* )
            echo "Restart cancelled."
            break
            ;;
        * )
            echo "Invalid option. Please enter Y or N."
            ;;
    esac
done
