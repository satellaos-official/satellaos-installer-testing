#!/bin/bash
set -e
set -u

echo "--------------------------------------"
echo " Available Programs"
echo "--------------------------------------"
echo " 1  - Google Chrome (Deb)"
echo " 2  - Opera Stable (Deb)"
echo " 3  - Vivaldi Stable (Deb)"
echo " 4  - Brave Browser (Deb)"
echo " 5  - Firefox ESR (Deb)"
echo " 6  - Steam (Deb)"
echo " 7  - Free Download Manager (Deb)"
echo " 8  - LocalSend 1.17.0 (Deb)"
echo " 9  - LocalSend (Flatpak)"
echo "10  - KDiskMark 3.2.0 (Deb)"
echo "11  - KDiskMark (Flatpak)"
echo "12  - VirtualBox 7.2.4 [Debian 13 (Deb)]"
echo "13  - GIMP (Deb)"
echo "14  - GIMP (Flatpak)"
echo "15  - Pinta (Flatpak)"
echo "16  - PowerISO (Flatpak)"
echo "17  - MenuLibre (Deb)"
echo "18  - Sublime Text (Deb)"
echo "19  - WineHQ Stable [Debian 13 (Deb)]"
echo "20  - Mission Center (Flatpak)"
echo "21  - GParted (Deb)"
echo "22  - GNOME Disk Utility (Deb)"
echo "23  - VLC (Deb)"
echo "24  - qBittorrent (Deb)"
echo "25  - Grub Customizer (Deb)"
echo "26  - Galculator (Deb)"
echo "27  - Gucharmap (Deb)"
echo "28  - Gnome Software (Deb)"
echo "29  - Mintstick (Deb)"
echo "30  - Warp VPN"
echo "31  - Disk Usage Analyzer"
echo "32  - Libre Office (Deb)"
echo "--------------------------------------"

PKG_DIR="$HOME/satellaos-packages"
mkdir -p "$PKG_DIR"

echo "Enter the numbers of the programs you want to install."
echo "Example: 1 3 5 14 21"
echo "Leave empty to install nothing."
read -r -p "Your selection (separate with spaces): " SELECTIONS
SELECTIONS="${SELECTIONS//,/}"

# Remove duplicates
SELECTIONS=$(echo "$SELECTIONS" | tr ' ' '\n' | sort -u)

# Empty input check
if [[ -z "$SELECTIONS" ]]; then
    echo "No selection made. Exiting."
    exit 0
fi

install_1() {
    wget -O "$PKG_DIR/google-chrome-stable_current_amd64.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y "$PKG_DIR/google-chrome-stable_current_amd64.deb"
}

install_2() {
wget -qO- https://deb.opera.com/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/opera-browser.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/opera-browser.gpg] https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera-archive.list

sudo apt-get update
sudo apt-get install opera-stable
}

install_3() {
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub \
  | gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi-browser.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/vivaldi-archive.list

sudo apt update
sudo apt install vivaldi-stable
}

install_4() {
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
        https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
    sudo apt update
    sudo apt install -y brave-browser
}

install_5() {
    sudo apt install -y firefox-esr
}

install_6() {
    wget -O "$PKG_DIR/steam_latest.deb" https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    sudo apt install -y "$PKG_DIR/steam_latest.deb"
}

install_7() {
    wget -O "$PKG_DIR/freedownloadmanager.deb" https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb
    sudo apt install -y "$PKG_DIR/freedownloadmanager.deb"
}

install_8() {
    wget -O "$PKG_DIR/LocalSend-1.17.0-linux-x86-64.deb" https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-linux-x86-64.deb
    sudo apt install -y "$PKG_DIR/LocalSend-1.17.0-linux-x86-64.deb"
}

install_9() {
    flatpak install -y --noninteractive flathub org.localsend.localsend_app
}

install_10() {
    wget -O "$PKG_DIR/kdiskmark_3.2.0_amd64.deb" https://github.com/JonMagon/KDiskMark/releases/download/3.2.0/kdiskmark_3.2.0_amd64.deb
    sudo apt install -y "$PKG_DIR/kdiskmark_3.2.0_amd64.deb"
}

install_11() {
    flatpak install -y --noninteractive flathub io.github.jonmagon.kdiskmark
}

install_12() {
    wget -O "$PKG_DIR/virtualbox-7.2_7.2.4-170995~Debian~trixie_amd64.deb" https://download.virtualbox.org/virtualbox/7.2.4/virtualbox-7.2_7.2.4-170995~Debian~trixie_amd64.deb
    sudo apt install -y "$PKG_DIR/virtualbox-7.2_7.2.4-170995~Debian~trixie_amd64.deb"
    wget -O "$PKG_DIR/Oracle_VirtualBox_Extension_Pack-7.2.4.vbox-extpack" https://download.virtualbox.org/virtualbox/7.2.4/Oracle_VirtualBox_Extension_Pack-7.2.4.vbox-extpack
    sudo VBoxManage extpack install --accept-license=eb31505e56e9b4d0fbca139104da41ac6f6b98f8e78968bdf01b1f3da3c4f9ae "$PKG_DIR/Oracle_VirtualBox_Extension_Pack-7.2.4.vbox-extpack"
}

install_13() {
    sudo apt install -y gimp
}

install_14() {
    flatpak install -y --noninteractive flathub org.gimp.GIMP
}

install_15() {
    flatpak install -y --noninteractive flathub com.github.PintaProject.Pinta
}

install_16() {
    flatpak install -y --noninteractive flathub com.poweriso.PowerISO
}

install_17() {
    sudo apt install -y menulibre
}

install_18() {
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
    echo -e "Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc" \
        | sudo tee /etc/apt/sources.list.d/sublime-text.sources
    sudo apt update
    sudo apt install -y sublime-text
}

install_19() {
    sudo mkdir -pm755 /etc/apt/keyrings
    wget -O - https://dl.winehq.org/wine-builds/winehq.key \
        | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
    sudo dpkg --add-architecture i386
    sudo wget -NP /etc/apt/sources.list.d/ \
        https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
    sudo apt update
    sudo apt install -y --install-recommends winehq-stable
}

install_20() {
    flatpak install -y --noninteractive flathub io.missioncenter.MissionCenter
}

install_21() {
    sudo apt install -y gparted
}

install_22() {
    sudo apt install -y gnome-disk-utility
}

install_23() {
    sudo apt install -y vlc
}

install_24() {
    sudo apt install -y qbittorrent
}

install_25() {
    sudo apt install -y grub-customizer
}

install_26() {
    sudo apt install -y galculator
}

install_27() {
    sudo apt install -y gucharmap
}

install_28() { 
    sudo apt install -y gnome-software gnome-software-plugin-flatpak
}

install_29() { 
    sudo apt install -y mintstick
}

install_30() { 
    
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    sudo apt-get update && sudo apt-get install cloudflare-warp
}

install_31() { 
    sudo apt install -y baobab
}

install_32() { 
    sudo apt install -y libreoffice libreoffice-gtk3
}

for i in $SELECTIONS; do
    if declare -f "install_$i" >/dev/null; then
        echo "[$i] Installing..."
        install_$i
    else
        echo "[$i] Invalid selection, skipped."
    fi
done

while true; do
    read -r -p "Do you want to delete all deb files to free up space? (Y/N): " CLEANUP
    case "$CLEANUP" in
        [Yy]* )
            rm -rf "$PKG_DIR"
            echo "Deb files have been deleted."
            break
            ;;
        [Nn]* )
            echo "Deb files have been kept."
            break
            ;;
        * )
            echo "Invalid option. Please enter Y or N."
            ;;
    esac
done


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
