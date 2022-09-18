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
cat <<EOF >> /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

# alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh                # Start Alis script

# Change default kernel and timeout
sed -E "s,archlinux\.conf,archlinux-zen.conf,g" -i /mnt/boot/loader/loader.conf
sed -E "s,timeout.*,timeout 0,g" -i /mnt/boot/loader/loader.conf

# Change default timeout sudo
echo -e "\nDefaults timestamp_timeout=240" >> /mnt/etc/sudoers

# Add persistent journalctl
mkdir -p /mnt/var/log/journal

# Download Custom alis under chroot system
mkdir -p /mnt/home/linux/appoggio
curl -sL https://github.com/$GITHUB_USER/alis/archive/refs/heads/$BRANCH.zip > /mnt/home/linux/appoggio/latitude5300.zip
arch-chroot /mnt unzip /home/linux/appoggio/latitude5300.zip -d /home/linux/appoggio
arch-chroot /mnt rm -fv /home/linux/appoggio/latitude5300.zip

# Download client_config repo under chroot 
curl -sL https://github.com/$GITHUB_USER/client_config/archive/refs/heads/$BRANCH.zip > /mnt/home/linux/appoggio/$BRANCH.zip
arch-chroot /mnt unzip /home/linux/appoggio/$BRANCH.zip -d /home/linux/appoggio
arch-chroot /mnt rm -fv /home/linux/appoggio/$BRANCH.zip

# Change passwd root and liunx
arch-chroot /mnt passwd root
arch-chroot /mnt passwd linux

# Change luks password
cryptsetup luksChangeKey /dev/nvme0n1p6 -S 0

# Enroll secure boot keys
# Ancora da testare! (tranne installazione sbctl) 
arch-chroot /mnt pacman -Sy sbctl --noconfirm --needed
arch-chroot /mnt /usr/bin/sbctl create-keys
arch-chroot /mnt /usr/bin/sbctl enroll-keys
arch-chroot /mnt /usr/bin/sbctl status
arch-chroot /mnt /usr/bin/sbctl verify | boot |
awk '{print $2}' | while read line; do sbctl sign $line; done
arch-chroot /mnt /usr/bin/sbctl verify

# Enroll luks system key to tpm
#systemd-cryptenroll /dev/nvme0n1p6 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
