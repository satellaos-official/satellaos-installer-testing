#!/bin/bash

sudo cp ~/satellaos-installer/grub/grub /etc/default/grub

sudo update-grub && sudo update-initramfs -u
