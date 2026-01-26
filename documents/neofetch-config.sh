#!/bin/bash

# Hedef dizin ve dosyalar
CONFIG_DIR="$HOME/.config/fastfetch"
CONFIG_FILE="$CONFIG_DIR/config.jsonc"
PRESET_FILE="/usr/share/fastfetch/presets/neofetch.jsonc"

# Dizin yoksa oluştur
mkdir -p "$CONFIG_DIR"

# Preset dosyası mevcut mu kontrol et
if [ -f "$PRESET_FILE" ]; then
    cp "$PRESET_FILE" "$CONFIG_FILE"
    echo "✅ Neofetch yapılandırması başarıyla $CONFIG_FILE dosyasına kopyalandı."
else
    echo "❌ Hata: $PRESET_FILE bulunamadı!"
    exit 1
fi
