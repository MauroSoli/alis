                  # Start the system with latest Arch Linux installation media
loadkeys it       # Load keyboard keymap, eg. loadkeys es, loadkeys us, loadkeys de

# Connect to WIFI
read -sp "Insert Wi-Fi Password: " wifiPass
wdevice=$(iwctl device list | grep wlan | awk '{print $1}')
iwctl station $wdevice scan
sleep 1
iwctl station $wdevice get-networks
echo 'iwctl --passphrase $wifiPass station $wdevice connect "[WIFI_ESSID]"'              # (Optional) Connect to WIFI network. _ip link show_ to know WIFI_INTERFACE.

curl -sL https://raw.githubusercontent.com/picodotdev/alis/master/download.sh | bash     # Download alis scripts                                                 # Alternative download URL with URL shortener
curl -sLo alis.conf https://raw.githubusercontent.com/MauroSoli/alis/master/alis.conf    #
#./alis-asciinema.sh      # (Optional) Start asciinema video recording
#./alis.sh      # (Optional) Start asciinema video recording
