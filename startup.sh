#./alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh      # (Optional) Start asciinema video recording

#change default kernel
#arch-chroot /mnt "sed -E 's,archlinux\.conf,archlinux-zen.conf,g' -i /boot/loader/loader.conf"

#arch-chroot /mnt 'sbctl create-keys; sbctl enroll-keys; sbctl status; sbctl verify'


# Enroll luks system key to tpm
#systemd-cryptenroll /dev/nvme0n1p1 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
