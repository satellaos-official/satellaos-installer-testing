#!/bin/bash
# Firefox çeviri özelliklerini devre dışı bırakır
# by Kiyotaka Ayanokoji :)

# Firefox profil dizinini bul (varsayılan profil)
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default*" | head -n 1)

# Eğer profil bulunamazsa hata ver
if [ -z "$PROFILE_DIR" ]; then
    echo "Firefox profili bulunamadı!"
    exit 1
fi

# user.js dosyasına ayarları ekle
echo "Firefox çeviri özellikleri devre dışı bırakılıyor..."
cat <<EOF > "$PROFILE_DIR/user.js"
// Firefox Translation settings disabled by script
user_pref("browser.translations.enable", false);
user_pref("browser.translations.automaticallyPopup", false);
EOF

echo "İşlem tamamlandı! Firefox'u yeniden başlatmanız yeterlidir."
