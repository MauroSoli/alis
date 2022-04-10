# Change DNS
#sed -E 's,nameserver.*,nameserver 8.8.8.8,g' -i /etc/resolv.conf

#Download alis and custom config
curl -sL https://raw.githubusercontent.com/picodotdev/alis/master/download.sh | bash          # Download alis scripts
curl -sL https://raw.githubusercontent.com/MauroSoli/alis/dell/alis.conf >> alis.conf         # Download custom alis.conf
curl -sL https://raw.githubusercontent.com/MauroSoli/alis/dell/alis-packages.conf >> alis-packages.conf          # Download custom alis.conf

#./alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh      

#change default kernel
sed -E "s,archlinux\.conf,archlinux-zen.conf,g" -i /mnt/boot/loader/loader.conf

#Download script after first setup
curl -sL https://raw.githubusercontent.com/MauroSoli/alis/dell/archBasePackages.sh > /mnt/tmp/archBasePackages.sh          

#Chroot script
arch-chroot /mnt /tmp/archBasePackages.sh

# Enroll secure boot keys
#arch-chroot /mnt 'sbctl create-keys; sbctl enroll-keys; sbctl status; sbctl verify'

# Enroll luks system key to tpm
#systemd-cryptenroll /dev/nvme0n1p1 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
