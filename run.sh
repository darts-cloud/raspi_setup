#!/bin/sh
sudo apt update -y
sudo apt full-upgrade -y
# sudo rpi-update -y
sudo apt install -y libatlas-base-dev

sudo apt-get install -y realvnc-vnc-server
sudo apt install -y libcamera-apps

./shell/bluetooth.sh
# ./shell/rtspserver.sh



