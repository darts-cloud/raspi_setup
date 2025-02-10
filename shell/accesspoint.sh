#!/bin/sh
# https://blog.soracom.com/ja-jp/2022/10/31/how-to-build-wifi-ap-with-bridge-by-raspberry-pi/#co-index-2

# main
sudo systemctl stop wpa_supplicant.service
sudo systemctl mask wpa_supplicant.service
cat << _EOT_ | sudo tee -a /etc/dhcpcd.conf
nohook wpa_supplicant
_EOT_
sudo systemctl restart dhcpcd.service

sudo systemctl status wpa_supplicant.service | grep Active:
ps h -C wpa_supplicant

# variables
_SSID_=darts
_WPA_KEY_=darts#3

# main
sudo apt install -y hostapd
sudo systemctl unmask hostapd.service
cat << _EOT_ | sudo SYSTEMD_EDITOR=tee systemctl edit hostapd.service

# Ref: /lib/systemd/system/raspberrypi-net-mods.service
[Unit]
Before = networking.service
[Service]
ExecStartPre = /bin/sh -c '/bin/rm -f /var/lib/systemd/rfkill/*.mmc*wlan'
ExecStartPre = /usr/sbin/rfkill unblock wifi
_EOT_
cat << _EOT_ | sudo tee /etc/hostapd/hostapd.conf
interface=wlan0
bridge=br0
driver=nl80211
ssid=${_SSID_}
hw_mode=g
channel=11
macaddr_acl=0
ignore_broadcast_ssid=0
auth_algs=1
ieee80211n=1
wme_enabled=1
country_code=JP
wpa=2
wpa_passphrase=${_WPA_KEY_}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
wpa_group_rekey=86400
_EOT_
sudo chmod 600 /etc/hostapd/hostapd.conf
history -d -8 # erase "_WPA_KEY_" in history
sudo systemctl start hostapd
