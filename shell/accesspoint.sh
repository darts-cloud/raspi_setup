#!/bin/sh
# https://blog.soracom.com/ja-jp/2022/10/31/how-to-build-wifi-ap-with-bridge-by-raspberry-pi/#co-index-2

# main
sudo nmcli connection add type wifi ifname wlan0 con-name rpi_ap autoconnect yes \
ssid raspida-lan \
802-11-wireless.mode ap \
802-11-wireless.band bg \
ipv4.method shared ipv4.address 192.168.2.1/24 \
wifi-sec.key-mgmt wpa-psk \
wifi-sec.pairwise ccmp \
wifi-sec.proto rsn \
wifi-sec.psk "darts#3"
