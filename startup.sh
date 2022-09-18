#!/usr/bin/env bash
set -eu

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2022 picodotdev
GITHUB_USER="picodotdev"
BRANCH="master"

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

# Change DNS
#sed -E 's,nameserver.*,nameserver 8.8.8.8,g' -i /etc/resolv.conf

# Download alis and custom config
#curl -sL https://raw.githubusercontent.com/MauroSoli/alis/latitude5300/download.sh | bash                             # Download alis scripts
#curl -sL https://raw.githubusercontent.com/MauroSoli/alis/latitude5300/alis.sh > alis.sh                         # Download alis.sh stable version
curl -sL https://raw.githubusercontent.com/MauroSoli/alis/latitude5300/alis.conf > alis.conf                     # Download custom alis.conf
#curl -sL https://raw.githubusercontent.com/MauroSoli/alis/latitude5300/alis-packages.conf >> alis-packages.conf  # Download custom alis-packages.conf
#curl -sL https://raw.githubusercontent.com/MauroSoli/alis/latitude5300/alis-commons.sh > alis-commons.sh  

# alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh                # Start Alis script

### Change default kernel and timeout
##sed -E "s,archlinux\.conf,archlinux-zen.conf,g" -i /mnt/boot/loader/loader.conf
##sed -E "s,timeout.*,timeout 0,g" -i /mnt/boot/loader/loader.conf
##
### Change default timeout sudo
##echo -e "\nDefaults timestamp_timeout=240" >> /mnt/etc/sudoers
##
### Add persistent journalctl
##mkdir -p /mnt/var/log/journal
##
### Download Custom alis inside chroot
##curl -sL https://github.com/MauroSoli/client_config/archive/refs/heads/latitude5300.zip > /mnt/home/linux/latitude5300.zip
##arch-chroot /mnt unzip /home/linux/latitude5300.zip -d /home/linux
##arch-chroot /mnt rm -fv /home/linux/latitude5300.zip
##
### Change passwd root and liunx
##arch-chroot /mnt passwd root
##arch-chroot /mnt passwd linux
##
### Change luks password
##cryptsetup luksChangeKey /dev/nvme0n1p6 -S 0
##
### Enroll secure boot keys
###arch-chroot /mnt /usr/bin/sbctl create-keys
###arch-chroot /mnt /usr/bin/sbctl enroll-keys
###arch-chroot /mnt /usr/bin/sbctl status
###arch-chroot /mnt /usr/bin/sbctl sign-all
###arch-chroot /mnt /usr/bin/sbctl verify
##
### Enroll luks system key to tpm
###systemd-cryptenroll /dev/nvme0n1p1 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
##
