#!/bin/sh
sudo apt install -y bluez-tools
sudo bash -c 'cat << EOF > /etc/systemd/network/pan0.netdev
[NetDev]
Name=pan0
Kind=bridge
EOF'

sudo bash -c 'cat << EOF > /etc/systemd/network/pan0.network
[Match]
Name=pan0

[Network]
Address=172.20.1.1/24 # 任意のプライベートIPアドレス
DHCPServer=yes
EOF'

sudo bash -c 'cat << EOF > /etc/systemd/system/bt-agent.service
[Unit]
Description=Bluetooth Auth Agent

[Service]
ExecStart=/usr/bin/bt-agent -c NoInputNoOutput
Type=simple

[Install]
WantedBy=multi-user.target
EOF'

sudo bash -c 'cat << EOF > /etc/systemd/system/bt-network.service
[Unit]
Description=Bluetooth NEP PAN
After=pan0.network

[Service]
ExecStart=/usr/bin/bt-network -s nap pan0
Type=simple

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl enable systemd-networkd
sudo systemctl enable bt-agent
sudo systemctl enable bt-network
sudo systemctl start systemd-networkd
sudo systemctl start bt-agent
sudo systemctl start bt-network
