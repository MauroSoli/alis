# Start the system with latest Arch Linux installation media
loadkeys it       # Load keyboard keymap, eg. loadkeys es, loadkeys us, loadkeys de

# Connect to WIFI
read -p  "Would you like to connect on wi-fi network?(yes/no): " WIFI_SET
if [ "WIFI_SET" ! "yes" ]; then
  WIFI_INTERFACE=$(iwctl device list | grep wlan | awk '{print $1}')
  iwctl station $WIFI_INTERFACE scan
  iwctl station $WIFI_INTERFACE get-networks
  sleep 1
  read -p  "Insert SSID Name: " WIFI_ESSID
  read -sp "Insert Wi-Fi Password: " WIFI_KEY
  iwctl --passphrase $WIFI_KEY station $WIFI_INTERFACE connect $WIFI_ESSID                 # (Optional) Connect to WIFI network. _ip link show_ to know WIFI_INTERFACE.
  if [ "$?" = "1" ]; then
    echo "Impossibile collegarsi a $WIFI_ESSID"
    exit 1
  fi
fi
echo -e "\n"
sleep 3

curl -sL https://raw.githubusercontent.com/picodotdev/alis/master/download.sh | bash         # Download alis scripts
curl -sL https://raw.githubusercontent.com/MauroSoli/alis/master/alis.conf > alis.conf  # Download custom alis.conf

#./alis-asciinema.sh      # (Optional) Start asciinema video recording
./alis.sh      # (Optional) Start asciinema video recording

##secure boot Installation
#pacman -Sy sbctl
#sbctl create-keys
#sbctl enroll-keys
#sbctl status
# after reboot

# Enroll luks system key to tpm
#systemd-cryptenroll /dev/nvme0n1p1 --tpm2-pcrs=1+7+8 --tpm2-device=auto --wipe-slot=tpm2
