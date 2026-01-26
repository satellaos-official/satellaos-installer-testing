#!/bin/bash

set -e

read -p "Do you want to install fonts? (Y/N): " answer

case "$answer" in
  Y|y)
    packages=(
      fonts-arabeyes fonts-liberation fonts-samyak-gujr fonts-tlwg-kinnari-ttf
      fonts-arundina fonts-liberation-sans-narrow fonts-samyak-mlym fonts-tlwg-laksaman
      fonts-beng fonts-lohit-beng-assamese fonts-samyak-taml fonts-tlwg-laksaman-ttf
      fonts-beng-extra fonts-lohit-beng-bengali fonts-sarai fonts-tlwg-loma
      fonts-bpg-georgian fonts-lohit-deva fonts-sil-abyssinica fonts-tlwg-loma-ttf
      fonts-culmus fonts-lohit-gujr fonts-sil-andika fonts-tlwg-mono
      fonts-dejavu fonts-lohit-guru fonts-sil-annapurna fonts-tlwg-mono-ttf
      fonts-dejavu-core fonts-lohit-knda fonts-sil-scheherazade fonts-tlwg-norasi
      fonts-dejavu-extra fonts-lohit-mlym fonts-smc fonts-tlwg-norasi-ttf
      fonts-dejavu-mono fonts-lohit-taml fonts-smc-anjalioldlipi fonts-tlwg-purisa
      fonts-deva fonts-lohit-taml-classical fonts-smc-chilanka fonts-tlwg-purisa-ttf
      fonts-deva-extra fonts-lohit-telu fonts-smc-dyuthi fonts-tlwg-sawasdee
      fonts-droid-fallback fonts-mathjax fonts-smc-gayathri fonts-tlwg-sawasdee-ttf
      fonts-dzongkha fonts-mlym fonts-smc-karumbi fonts-tlwg-typewriter
      fonts-farsiweb fonts-nakula fonts-smc-keraleeyam fonts-tlwg-typewriter-ttf
      fonts-font-awesome fonts-noto fonts-smc-manjari fonts-tlwg-typist
      fonts-freefont-ttf fonts-noto-cjk fonts-smc-meera fonts-tlwg-typist-ttf
      fonts-gargi fonts-noto-cjk-extra fonts-smc-rachana fonts-tlwg-typo
      fonts-gujr fonts-noto-color-emoji fonts-smc-raghumalayalamsans fonts-tlwg-typo-ttf
      fonts-gujr-extra fonts-noto-core fonts-smc-suruma fonts-tlwg-umpush
      fonts-guru fonts-noto-extra fonts-smc-uroob fonts-tlwg-umpush-ttf
      fonts-guru-extra fonts-noto-mono fonts-symbola fonts-tlwg-waree
      fonts-hosny-amiri fonts-noto-ui-core fonts-taml fonts-tlwg-waree-ttf
      fonts-hosny-thabit fonts-noto-ui-extra fonts-telu fonts-ukij-uyghur
      fonts-ipafont fonts-noto-unhinted fonts-telu-extra fonts-unifont
      fonts-ipafont-gothic fonts-opensymbol fonts-teluguvijayam fonts-unikurdweb
      fonts-ipafont-mincho fonts-quicksand fonts-thai-tlwg fonts-urw-base35
      fonts-kalapi fonts-sahadeva fonts-tlwg-garuda fonts-vazirmatn-variable
      fonts-khmeros fonts-sahel-variable fonts-tlwg-garuda-ttf fonts-vlgothic
      fonts-lato fonts-samyak-deva fonts-tlwg-kinnari fonts-yrsa-rasa
    )

    sudo apt update
    sudo apt install -y "${packages[@]}"
    ;;
  N|n)
    echo "Font installation skipped."
    ;;
  *)
    echo "Invalid choice. Please enter Y or N."
    exit 1
    ;;
esac
