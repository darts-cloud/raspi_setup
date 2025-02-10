#!/bin/sh
# v4l2rtspserver
sudo apt-get install -y cmake
sudo apt-get install -y liblivemedia-dev
cd ~/
git clone https://github.com/mpromonet/h264_v4l2_rtspserver.git
cd h264_v4l2_rtspserver
sudo cmake .
sudo make install

ls -la /usr/local/bin/v4l2rtspserver

sudo cp /usr/lib/systemd/system/v4l2rtspserver.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable v4l2rtspserver
sudo reboot
