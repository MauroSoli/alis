#!/bin/bash
set -eu

# systemd-resolvd binary
pacman -Sy systemd-resolvconf --noconfirm --needed

# Pipewire packages + webrtc
# lib32-pipewire lib32-pipewire-jack
sudo pacman -R  jack2
sudo pacman -S  pipewire-jack libpipewire02 pipewire pipewire-alsa pipewire-pulse gst-plugin-pipewire --noconfirm --needed
sudo pacman -S  xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk --noconfirm --needed

# Gnome software
sudo pacman -S gnome-shell  gnome-terminal  gnome-tweak-tool gnome-control-center xdg-user-dirs gdm --noconfirm --needed
sudo pacman -S nautilus --noconfirm --needed
sudo pacman -S gnome-software gnome-software-packagekit-plugin gnome-multi-writer --noconfirm --needed
sudo pacman -S networkmanager-fortisslvpn --noconfirm --needed
pacman -S gnome-tweaks gnome-shell-extensions --noconfirm --needed
yay -S chrome-gnome-shell --noconfirm --needed

# Essential tools/software
sudo pacman -S git subversion --needed
git lfs install
yay -Sy nautilus-compare --noconfirm --needed
sudo pacman -S kubectl --needed
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

#Cloud CLI
sudo pacman -S aws-cli --noconfirm --needed
yay -S google-cloud-sdk --noconfirm --needed

# Hypervisor section
sudo pacman -S vagrant virt-manager iptables-nft bridge-utils openbsd-netcat --noconfirm --needed

# Optional software
sudo pacman -S telegram-desktop --noconfirm --needed
yay -S lens --noconfirm --needed
pacman -S solaar --noconfirm --needed
pacman -S ipcalc --noconfirm --needed

# Fonts
sudo pacman -S ttf-cascadia-code --noconfirm --needed