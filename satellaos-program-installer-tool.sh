#!/bin/bash

set -e
set -u

if ! command -v whiptail &>/dev/null; then
    sudo apt install -y whiptail
fi

VERSION="5.3.0"

CHOICES=$(whiptail --title "SatellaOS Installer v$VERSION" \
    --checklist "Select the programs you want to install:\n(SPACE to mark, ENTER to confirm, TAB to switch between OK/Cancel)" \
    40 70 30 \
    "1"  "Brave Browser (Deb)"                      OFF \
    "2"  "Chromium Browser (Deb)"                   OFF \
    "3"  "Firefox ESR (Deb)"                        OFF \
    "4"  "Firefox (Portable)"                       OFF \
    "5"  "Floorp Browser (Portable)"                OFF \
    "6"  "Google Chrome (Deb)"                      OFF \
    "7"  "Opera Stable (Deb)"                       OFF \
    "8"  "Tor Browser (Deb)"                        OFF \
    "9"  "Vivaldi Stable (Deb)"                     OFF \
    "10" "Waterfox (Portable)"                      OFF \
    "11" "Zen Browser (Portable)"                   OFF \
    "12" "Bitwarden (Flatpak)"                      OFF \
    "13" "BleachBit (Deb)"                          OFF \
    "14" "Discord (Flatpak)"                        OFF \
    "15" "Disk Usage Analyzer - baobab (Deb)"       OFF \
    "16" "Flatseal (Flatpak)"                       OFF \
    "17" "Free Download Manager (Deb)"              OFF \
    "18" "Galculator (Deb)"                         OFF \
    "19" "GIMP (Deb)"                               OFF \
    "20" "GIMP (Flatpak)"                           OFF \
    "21" "GNOME Disk Utility (Deb)"                 OFF \
    "22" "Gnome Software (Deb)"                     OFF \
    "23" "GParted (Deb)"                            OFF \
    "24" "Grub Customizer (Deb)"                    OFF \
    "25" "Gucharmap (Deb)"                          OFF \
    "26" "Heroic Games Launcher (Deb)"              OFF \
    "27" "Heroic Games Launcher (Flatpak)"          OFF \
    "28" "Inkscape (Deb)"                           OFF \
    "29" "KDiskMark (Deb)"                          OFF \
    "30" "KDiskMark (Flatpak)"                      OFF \
    "31" "KeePassXC (Deb)"                          OFF \
    "32" "Krita (Flatpak)"                          OFF \
    "33" "Libre Office (Deb)"                       OFF \
    "34" "LocalSend (Deb)"                          OFF \
    "35" "LocalSend (Flatpak)"                      OFF \
    "36" "Lutris (Deb)"                             OFF \
    "37" "Lutris (Flatpak)"                         OFF \
    "38" "MenuLibre (Deb)"                          OFF \
    "39" "Mintstick (Deb)"                          OFF \
    "40" "Mission Center (Flatpak)"                 OFF \
    "41" "OBS Studio (Flatpak)"                     OFF \
    "42" "Obsidian (Flatpak)"                       OFF \
    "43" "Pinta (Flatpak)"                          OFF \
    "44" "PowerISO (Flatpak)"                       OFF \
    "45" "qBittorrent (Deb)"                        OFF \
    "46" "Ristretto (Deb)"                          OFF \
    "47" "Screen Keyboard - Onboard (Deb)"          OFF \
    "48" "Signal (Deb)"                             OFF \
    "49" "Steam (Deb)"                              OFF \
    "50" "Sublime Text (Deb)"                       OFF \
    "51" "Telegram (Flatpak)"                       OFF \
    "52" "Thunderbird (Deb)"                        OFF \
    "53" "Timeshift (Deb)"                          OFF \
    "54" "VirtualBox [Debian 13 (Deb)]"             OFF \
    "55" "VLC (Deb)"                                OFF \
    "56" "VS Code (Deb)"                            OFF \
    "57" "Warp VPN"                                 OFF \
    "58" "WineHQ Stable [Debian 13 (Deb)]"          OFF \
    "59" "Wireshark (Deb)"                          OFF \
    3>&1 1>&2 2>&3)

# Exit if the user pressed Cancel
if [ $? -ne 0 ]; then
    echo "Cancelled. Exiting."
    exit 0
fi

# Remove quotes and duplicates
SELECTIONS=$(echo "$CHOICES" | tr -d '"' | tr ' ' '\n' | sort -u)

if [[ -z "$SELECTIONS" ]]; then
    whiptail --title "SatellaOS Installer" --msgbox "No program selected. Exiting." 8 40
    exit 0
fi

# ── Confirmation screen ──
CONFIRM_LIST=$(echo "$SELECTIONS" | tr '\n' ' ')
whiptail --title "Confirmation" --yesno "The following numbered programs will be installed:\n\n$CONFIRM_LIST\n\nDo you want to continue?" 15 60
if [ $? -ne 0 ]; then
    echo "Cancelled."
    exit 0
fi

PKG_DIR=$(mktemp -d /tmp/satellaos-installer-XXXXXX)
trap 'rm -rf "$PKG_DIR"' EXIT

# ── 1 ── Brave Browser
install_1() {
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources \
        https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
    sudo apt update
    sudo apt install -y brave-browser
}

# ── 2 ── Chromium Browser
install_2() {
    sudo apt install -y chromium
}

# ── 3 ── Firefox ESR
install_3() {
    sudo apt install -y firefox-esr
}

# ── 4 ── Firefox (Portable)
install_4() {
    LATEST_VERSION=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json | grep -Po '"LATEST_FIREFOX_VERSION":\s*"\K[^"]+')
    FILE="$PKG_DIR/firefox-$LATEST_VERSION.tar.xz"
    URL="https://ftp.mozilla.org/pub/firefox/releases/$LATEST_VERSION/linux-x86_64/en-US/firefox-$LATEST_VERSION.tar.xz"

    wget -O "$FILE" "$URL"
    sudo rm -rf /opt/firefox
    tar -xf "$FILE" -C "$PKG_DIR"
    sudo mv "$PKG_DIR/firefox" /opt/firefox
    sudo ln -sf /opt/firefox/firefox /usr/local/bin/firefox

    sudo tee /usr/share/applications/firefox.desktop > /dev/null <<EOL
[Desktop Entry]
Version=1.0
Name=Firefox
Comment=Mozilla Firefox Web Browser
Exec=/opt/firefox/firefox %u
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=firefox
EOL
    update-desktop-database /usr/share/applications 2>/dev/null || true
    xdg-mime default firefox.desktop x-scheme-handler/http
    xdg-mime default firefox.desktop x-scheme-handler/https
    xdg-settings set default-web-browser firefox.desktop
}

# ── 5 ── Floorp Browser (Portable)
install_5() {
    REPO="Floorp-Projects/Floorp"
    ASSET_NAME="floorp-linux-x86_64.tar.xz"

    LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
        | grep -oP '"tag_name": "\K(.*)(?=")')
    [ -z "$LATEST_TAG" ] && return 1

    FILE="$PKG_DIR/floorp.tar.xz"
    DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_TAG/$ASSET_NAME"
    wget -O "$FILE" "$DOWNLOAD_URL"

    sudo rm -rf /opt/floorp
    tar -xf "$FILE" -C "$PKG_DIR"
    DIR_NAME=$(tar -tf "$FILE" | head -1 | cut -f1 -d"/")
    sudo mv "$PKG_DIR/$DIR_NAME" /opt/floorp
    sudo ln -sf /opt/floorp/floorp /usr/local/bin/floorp

    ICON_PATH="/opt/floorp/browser/chrome/icons/default/default128.png"

    sudo tee /usr/share/applications/floorp.desktop > /dev/null <<EOL
[Desktop Entry]
Version=1.0
Name=Floorp Browser
Comment=Floorp Web Browser
Exec=/opt/floorp/floorp %u
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=floorp
EOL

    update-desktop-database /usr/share/applications 2>/dev/null || true
    xdg-mime default floorp.desktop x-scheme-handler/http
    xdg-mime default floorp.desktop x-scheme-handler/https
    xdg-settings set default-web-browser floorp.desktop
}

# ── 6 ── Google Chrome
install_6() {
    wget -O "$PKG_DIR/google-chrome-stable_current_amd64.deb" \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y "$PKG_DIR/google-chrome-stable_current_amd64.deb"
}

# ── 7 ── Opera Stable
install_7() {
    wget -qO- https://deb.opera.com/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/opera-browser.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/opera-browser.gpg] https://deb.opera.com/opera-stable/ stable non-free" \
        | sudo tee /etc/apt/sources.list.d/opera-archive.list
    sudo apt-get update
    sudo apt-get install -y opera-stable
}

# ── 8 ── Tor Browser
install_8() {
    sudo apt install -y torbrowser-launcher
    torbrowser-launcher
}

# ── 9 ── Vivaldi Stable
install_9() {
    wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub \
        | gpg --dearmor | sudo tee /usr/share/keyrings/vivaldi-browser.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" \
        | sudo tee /etc/apt/sources.list.d/vivaldi-archive.list
    sudo apt update
    sudo apt install -y vivaldi-stable
}

# ── 10 ── Waterfox (Portable)
install_10() {
    WATERFOX_VERSION="6.5.0"
    FILE="$PKG_DIR/waterfox-$WATERFOX_VERSION.tar.bz2"
    URL="https://cdn.waterfox.com/waterfox/releases/$WATERFOX_VERSION/Linux_x86_64/waterfox-$WATERFOX_VERSION.tar.bz2"

    wget -O "$FILE" "$URL"
    sudo rm -rf /opt/waterfox
    tar -xjf "$FILE" -C "$PKG_DIR"
    sudo mv "$PKG_DIR/waterfox" /opt/waterfox
    sudo ln -sf /opt/waterfox/waterfox /usr/local/bin/waterfox

    ICON_PATH="/opt/waterfox/browser/chrome/icons/default/default128.png"

    sudo tee /usr/share/applications/waterfox.desktop > /dev/null <<EOL
[Desktop Entry]
Version=1.0
Name=Waterfox
Comment=Waterfox Web Browser
Exec=/opt/waterfox/waterfox %u
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=waterfox
EOL

    update-desktop-database /usr/share/applications 2>/dev/null || true
    xdg-mime default waterfox.desktop x-scheme-handler/http
    xdg-mime default waterfox.desktop x-scheme-handler/https
    xdg-settings set default-web-browser waterfox.desktop
}

# ── 11 ── Zen Browser (Portable)
install_11() {
    FILE="$PKG_DIR/zen.linux-x86_64.tar.xz"
    wget -O "$FILE" https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz

    sudo rm -rf /opt/zen-browser
    tar -xf "$FILE" -C "$PKG_DIR"
    sudo mv "$PKG_DIR/zen" /opt/zen-browser

    BIN_PATH="/opt/zen-browser/zen"
    sudo ln -sf "$BIN_PATH" /usr/local/bin/zen-browser

    ICON_PATH="/opt/zen-browser/browser/chrome/icons/default/default128.png"

    sudo tee /usr/share/applications/zen-browser.desktop > /dev/null <<EOL
[Desktop Entry]
Version=1.0
Name=Zen Browser
Comment=Zen Web Browser
Exec=$BIN_PATH %u
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=zen
EOL

    update-desktop-database /usr/share/applications 2>/dev/null || true
    xdg-mime default zen-browser.desktop x-scheme-handler/http
    xdg-mime default zen-browser.desktop x-scheme-handler/https
    xdg-settings set default-web-browser zen-browser.desktop
}

# ── 12 ── Bitwarden (Flatpak)
install_12() {
    flatpak install -y --noninteractive flathub com.bitwarden.desktop
}

# ── 13 ── BleachBit (Deb)
install_13() {
    sudo apt install -y bleachbit
}

# ── 14 ── Discord (Flatpak)
install_14() {
    flatpak install flathub com.discordapp.Discord
}

# ── 15 ── Disk Usage Analyzer - baobab (Deb)
install_15() {
    sudo apt install -y baobab
}

# ── 16 ── Flatseal (Flatpak)
install_16() {
    flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal
}

# ── 17 ── Free Download Manager (Deb)
install_17() {
    wget -O "$PKG_DIR/freedownloadmanager.deb" \
        https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb
    sudo apt install -y "$PKG_DIR/freedownloadmanager.deb"
}

# ── 18 ── Galculator (Deb)
install_18() {
    sudo apt install -y galculator
}

# ── 19 ── GIMP (Deb)
install_19() {
    sudo apt install -y gimp
}

# ── 20 ── GIMP (Flatpak)
install_20() {
    flatpak install -y --noninteractive flathub org.gimp.GIMP
}

# ── 21 ── GNOME Disk Utility (Deb)
install_21() {
    sudo apt install -y gnome-disk-utility
}

# ── 22 ── Gnome Software (Deb)
install_22() {
    sudo apt install -y gnome-software gnome-software-plugin-flatpak
}

# ── 23 ── GParted (Deb)
install_23() {
    sudo apt install -y gparted
}

# ── 24 ── Grub Customizer (Deb)
install_24() {
    sudo apt install -y grub-customizer
}

# ── 25 ── Gucharmap (Deb)
install_25() {
    sudo apt install -y gucharmap
}

# ── 26 ── Heroic Games Launcher (Deb)
install_26() {
    HEROIC_URL=$(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest \
        | grep "browser_download_url" | grep "linux-amd64.deb" | cut -d '"' -f 4)
    HEROIC_FILE=$(basename "$HEROIC_URL")
    wget -O "$PKG_DIR/$HEROIC_FILE" "$HEROIC_URL"
    sudo apt install -y "$PKG_DIR/$HEROIC_FILE"
}

# ── 27 ── Heroic Games Launcher (Flatpak)
install_27() {
    flatpak install -y --noninteractive flathub com.heroicgameslauncher.hgl
}

# ── 28 ── Inkscape (Deb)
install_28() {
    sudo apt install -y inkscape
}

# ── 29 ── KDiskMark (Deb)
install_29() {
    KDISKMARK_URL=$(curl -s https://api.github.com/repos/JonMagon/KDiskMark/releases/latest \
        | grep "browser_download_url" | grep "amd64.deb" | cut -d '"' -f 4)
    KDISKMARK_FILE=$(basename "$KDISKMARK_URL")
    wget -O "$PKG_DIR/$KDISKMARK_FILE" "$KDISKMARK_URL"
    sudo apt install -y "$PKG_DIR/$KDISKMARK_FILE"
}

# ── 30 ── KDiskMark (Flatpak)
install_30() {
    flatpak install -y --noninteractive flathub io.github.jonmagon.kdiskmark
}

# ── 31 ── KeePassXC (Deb)
install_31() {
    sudo apt install -y keepassxc
}

# ── 32 ── Krita (Flatpak)
install_32() {
    flatpak install -y --noninteractive flathub org.kde.krita
}

# ── 33 ── Libre Office (Deb)
install_33() {
    sudo apt install -y libreoffice libreoffice-gtk3
}

# ── 34 ── LocalSend (Deb)
install_34() {
    LOCALSEND_URL=$(curl -s https://api.github.com/repos/localsend/localsend/releases/latest \
        | grep "browser_download_url" | grep "linux-x86-64.deb" | cut -d '"' -f 4)
    LOCALSEND_FILE=$(basename "$LOCALSEND_URL")
    wget -O "$PKG_DIR/$LOCALSEND_FILE" "$LOCALSEND_URL"
    sudo apt install -y "$PKG_DIR/$LOCALSEND_FILE"
}

# ── 35 ── LocalSend (Flatpak)
install_35() {
    flatpak install -y --noninteractive flathub org.localsend.localsend_app
}

# ── 36 ── Lutris (Deb)
install_36() {
    echo -e "Types: deb\nURIs: https://download.opensuse.org/repositories/home:/strycore:/lutris/Debian_13/\nSuites: ./\nComponents: \nSigned-By: /etc/apt/keyrings/lutris.gpg" \
        | sudo tee /etc/apt/sources.list.d/lutris.sources > /dev/null
    wget -q -O- https://download.opensuse.org/repositories/home:/strycore:/lutris/Debian_13/Release.key \
        | sudo gpg --dearmor -o /etc/apt/keyrings/lutris.gpg
    sudo apt update
    sudo apt install -y lutris
}

# ── 37 ── Lutris (Flatpak)
install_37() {
    flatpak install -y --noninteractive flathub net.lutris.Lutris
}

# ── 38 ── MenuLibre (Deb)
install_38() {
    sudo apt install -y menulibre
}

# ── 39 ── Mintstick (Deb)
install_39() {
    sudo apt install -y mintstick
}

# ── 40 ── Mission Center (Flatpak)
install_40() {
    flatpak install -y --noninteractive flathub io.missioncenter.MissionCenter
}

# ── 41 ── OBS Studio (Flatpak)
install_41() {
    flatpak install -y --noninteractive flathub com.obsproject.Studio
}

# ── 42 ── Obsidian (Flatpak)
install_42() {
    flatpak install -y --noninteractive flathub md.obsidian.Obsidian
}

# ── 43 ── Pinta (Flatpak)
install_43() {
    flatpak install -y --noninteractive flathub com.github.PintaProject.Pinta
}

# ── 44 ── PowerISO (Flatpak)
install_44() {
    flatpak install -y --noninteractive flathub com.poweriso.PowerISO
}

# ── 45 ── qBittorrent (Deb)
install_45() {
    sudo apt install -y qbittorrent
}

# ── 46 ── Ristretto (Deb)
install_46() {
    sudo apt install -y ristretto \
        libwebp7 \
        tumbler \
        tumbler-plugins-extra \
        webp-pixbuf-loader
}

# ── 47 ── Screen Keyboard - Onboard (Deb)
install_47() {
    sudo apt install -y onboard
}

# ── 48 ── Signal (Deb)
install_48() {
    wget -qO- https://updates.signal.org/desktop/apt/keys.asc \
        | gpg --dearmor | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] \
https://updates.signal.org/desktop/apt xenial main" \
        | sudo tee /etc/apt/sources.list.d/signal-xenial.list
    sudo apt update
    sudo apt install -y signal-desktop
}

# ── 49 ── Steam (Deb)
install_49() {
    wget -O "$PKG_DIR/steam_latest.deb" \
        https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    sudo apt install -y "$PKG_DIR/steam_latest.deb"
}

# ── 50 ── Sublime Text (Deb)
install_50() {
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
        | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
    echo -e "Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc" \
        | sudo tee /etc/apt/sources.list.d/sublime-text.sources
    sudo apt update
    sudo apt install -y sublime-text
}

# ── 51 ── Telegram (Flatpak)
install_51() {
    flatpak install -y --noninteractive flathub org.telegram.desktop
}

# ── 52 ── Thunderbird (Deb)
install_52() {
    sudo apt install -y thunderbird
}

# ── 53 ── Timeshift (Deb)
install_53() {
    sudo apt install -y timeshift
}

# ── 54 ── VirtualBox [Debian 13 (Deb)]
install_54() {
    wget -O oracle_vbox_2016.asc https://www.virtualbox.org/download/oracle_vbox_2016.asc
    sudo gpg --yes --output /usr/share/keyrings/oracle_vbox_2016.gpg --dearmor oracle_vbox_2016.asc
    sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null <<EOF
deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] https://download.virtualbox.org/virtualbox/debian trixie contrib
EOF
    sudo apt-get update
    sudo apt-get install -y virtualbox-7.2
    sudo usermod -aG vboxusers "$USER"

    FULL_VERSION=$(dpkg-query -W -f='${Version}' virtualbox-7.2)
    VBOX_VERSION=$(echo "$FULL_VERSION" | cut -d '-' -f1)
    VBOX_BUILD=$(echo "$FULL_VERSION" | cut -d '-' -f2 | cut -d '~' -f1)

    EXT_PACK_FILE="/tmp/Oracle_VirtualBox_Extension_Pack-${VBOX_VERSION}-${VBOX_BUILD}.vbox-extpack"
    EXT_PACK_URL="https://download.virtualbox.org/virtualbox/${VBOX_VERSION}/Oracle_VirtualBox_Extension_Pack-${VBOX_VERSION}-${VBOX_BUILD}.vbox-extpack"

    wget -O "$EXT_PACK_FILE" "$EXT_PACK_URL"
    echo y | sudo VBoxManage extpack install --replace "$EXT_PACK_FILE"
    rm -f "$EXT_PACK_FILE"
}

# ── 55 ── VLC (Deb)
install_55() {
    sudo apt install -y vlc
}

# ── 56 ── VS Code (Deb)
install_56() {
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-archive-keyring.gpg > /dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] \
https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
    sudo apt install -y code
}

# ── 57 ── Warp VPN
install_57() {
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg \
        | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
        | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    sudo apt-get update && sudo apt-get install -y cloudflare-warp
}

# ── 58 ── WineHQ Stable [Debian 13 (Deb)]
install_58() {
    sudo mkdir -pm755 /etc/apt/keyrings
    wget -O - https://dl.winehq.org/wine-builds/winehq.key \
        | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
    sudo dpkg --add-architecture i386
    sudo wget -NP /etc/apt/sources.list.d/ \
        https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
    sudo apt update
    sudo apt install -y --install-recommends winehq-stable
}

# ── 59 ── Wireshark (Deb)
install_59() {
    sudo apt install -y wireshark
}

# ────────────────────────────────────────────
TOTAL=$(echo "$SELECTIONS" | wc -w)
CURRENT=0

for i in $SELECTIONS; do
    CURRENT=$((CURRENT + 1))
    if declare -f "install_$i" >/dev/null; then
        echo "[$CURRENT/$TOTAL] Installing program $i..."
        install_$i && echo "[$CURRENT/$TOTAL] Program $i installed ✓" || echo "[$CURRENT/$TOTAL] ERROR occurred while installing program $i ✗"
    else
        echo "[$CURRENT/$TOTAL] Invalid selection: $i, skipping."
    fi
done