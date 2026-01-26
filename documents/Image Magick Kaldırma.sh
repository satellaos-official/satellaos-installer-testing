#!/bin/bash
# ImageMagick ve ilgili paketleri tamamen kaldırır

echo "ImageMagick paketleri kaldırılıyor..."
sudo apt purge -y imagemagick imagemagick-6-common imagemagick-6.q16

echo "Kaldırma işlemi tamamlandı."
