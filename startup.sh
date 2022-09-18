#!/usr/bin/env bash
set -eu

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2022 picodotdev
GITHUB_USER="MauroSoli"
BRANCH="latitude5300"

while getopts "u:" arg; do
  case ${arg} in
    u)
      GITHUB_USER=${OPTARG}
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

set -o xtrace
curl -sL -o "alis-$BRANCH.zip" https://github.com/$GITHUB_USER/alis/archive/refs/heads/$BRANCH.zip
bsdtar -x -f "alis-$BRANCH.zip"
cp -R alis-$BRANCH/*.sh alis-$BRANCH/*.conf alis-$BRANCH/files/ alis-$BRANCH/configs/ ./
chmod +x configs/*.sh
chmod +x *.sh

# Disable IPV6
sysctl -w net.ipv6.conf.all.disable_ipv6=1

# alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh                # Start Alis script

###temp # Change default kernel and timeout
###temp sed -E "s,archlinux\.conf,archlinux-zen.conf,g" -i /mnt/boot/loader/loader.conf
###temp sed -E "s,timeout.*,timeout 0,g" -i /mnt/boot/loader/loader.conf
###temp 
###temp # Change default timeout sudo
###temp echo -e "\nDefaults timestamp_timeout=240" >> /mnt/etc/sudoers
###temp 
###temp # Add persistent journalctl
###temp mkdir -p /mnt/var/log/journal
###temp 
###temp # Download Custom alis under chroot system
###temp mkdir -p /mnt/home/linux/appoggio
###temp curl -sL https://github.com/$GITHUB_USER/alis/archive/refs/heads/$BRANCH.zip > /mnt/home/linux/appoggio/latitude5300.zip
###temp arch-chroot /mnt unzip /home/linux/appoggio/latitude5300.zip -d /home/linux/appoggio
###temp arch-chroot /mnt rm -fv /home/linux/appoggio/latitude5300.zip
###temp 
###temp # Download client_config repo under chroot 
###temp curl -sL https://github.com/$GITHUB_USER/client_config/archive/refs/heads/$BRANCH.zip > /mnt/home/linux/appoggio/$BRANCH.zip
###temp arch-chroot /mnt unzip /home/linux/appoggio/$BRANCH.zip -d /home/linux/appoggio
###temp arch-chroot /mnt rm -fv /home/linux/appoggio/$BRANCH.zip
###temp 
###temp # Change passwd root and liunx
###temp arch-chroot /mnt passwd root
###temp arch-chroot /mnt passwd linux
###temp 
###temp # Change luks password
###temp cryptsetup luksChangeKey /dev/nvme0n1p6 -S 0
###temp 
###temp # Enroll secure boot keys
###temp # Ancora da testare! (tranne installazione sbctl) 
###temp arch-chroot /mnt pacman -Sy sbctl --noconfirm --needed
###temp #arch-chroot /mnt /usr/bin/sbctl create-keys
###temp #arch-chroot /mnt /usr/bin/sbctl enroll-keys
###temp #arch-chroot /mnt /usr/bin/sbctl status
###temp #arch-chroot /mnt /usr/bin/sbctl verify | boot |
###temp #awk '{print $2}' | while read line; do sbctl sign $line; done
###temp #arch-chroot /mnt /usr/bin/sbctl verify
###temp 
###temp # Enroll luks system key to tpm
###temp #systemd-cryptenroll /dev/nvme0n1p6 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
###temp 
