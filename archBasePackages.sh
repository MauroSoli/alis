#!/bin/bash
set -eu

#Install git and yay
sudo pacman -Sy git subversion --noconfirm --needed
if [ ! -f "/bin/yay" ]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# systemd-resolvd binary
sudo pacman -S systemd-resolvconf --noconfirm --needed

# Pipewire packages + webrtc
# lib32-pipewire lib32-pipewire-jack
sudo pacman -S  pipewire-jack libpipewire02 pipewire pipewire-alsa pipewire-pulse gst-plugin-pipewire --needed
sudo pacman -S  xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk --noconfirm --needed

# Gnome software
sudo pacman -S gnome-shell  gnome-terminal  gnome-tweak-tool gnome-control-center xdg-user-dirs gdm --noconfirm --needed
sudo pacman -S nautilus --noconfirm --needed
sudo pacman -S gnome-software gnome-software-packagekit-plugin gnome-multi-writer --noconfirm --needed
sudo pacman -S networkmanager-fortisslvpn --noconfirm --needed
sudo pacman -S gnome-tweaks gnome-shell-extensions --noconfirm --needed
yay -S chrome-gnome-shell --noconfirm --needed

# Essential tools/software
sudo pacman -S git-lfs --noconfirm --needed
git lfs install 
sudo pacman -S vi net-tools --noconfirm --needed
yay -Sy nautilus-compare --noconfirm --needed
sudo pacman -S kubectl --noconfirm --needed
sudo pacman -S rclone --noconfirm --needed
sudo pacman -S duplicity python-requests-oauthlib --noconfirm --needed 
sudo pacman -S rsnapshot --noconfirm --needed
sudo pacman -S lshw --noconfirm --needed
sudo pacman -S jre-openjdk --noconfirm --needed
sudo pacman -S podman --noconfirm --needed
sudo pacman -S traceroute --noconfirm --needed
sudo pacman -S openfortivpn --noconfirm --needed
sudo pacman -S terragrunt --noconfirm --needed
sudo pacman -S obs-studio --noconfirm --needed
sudo pacman -S ansible --noconfirm --needed
sudo pacman -S mariadb-clients --noconfirm --needed
yay -S google-chrome --noconfirm --needed
yay -S openfortigui --noconfirm --needed
yay -S tigervnc-viewer  --noconfirm --needed

# Code editors
sudo pacman -Sy code --noconfirm --needed
sudo pacman -Sy atom --noconfirm --needed

#Cloud CLI
sudo pacman -S aws-cli --noconfirm --needed
yay -S google-cloud-sdk --noconfirm --needed

# Hypervisor section
yes | sudo pacman -S iptables-nft --noconfirm --needed
sudo pacman -S vagrant virt-manager bridge-utils openbsd-netcat --noconfirm --needed

# Optional software
sudo pacman -S telegram-desktop --noconfirm --needed
yay -S lens --removemake --noconfirm --needed 
sudo pacman -S solaar --noconfirm --needed
sudo pacman -S ipcalc --noconfirm --needed

# Fonts
sudo pacman -S ttf-cascadia-code --noconfirm --needed
