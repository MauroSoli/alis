#!/bin/bash
sudo pacman -Sy archlinux-keyring --noconfirm
sudo pacman -Syu
yay -Syu
#systemd-cryptenroll /dev/nvme0n1p1 --tpm2-pcrs=7+8 --tpm2-device=auto --wipe-slot=tpm2