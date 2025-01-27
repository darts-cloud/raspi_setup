# raspi_setup
個人的なRaspberryPiセットアップ用のスクリプトです。

## USBでの接続
https://qiita.com/Liesegang/items/dcdc669f80d1bf721c21

## VNCでの接続
https://dev.classmethod.jp/articles/raspberry-pi-4-ssh-vnc-remote/

## bluetoothでの接続
https://memo.appri.me/iot/rpi0-bluetooth-ssh#PC%E5%81%B4%E3%81%8B%E3%82%89%E3%83%A9%E3%82%BA%E3%83%91%E3%82%A4%E3%81%ABBluetooth%E7%B5%8C%E7%94%B1%E3%81%A7SSH%E6%8E%A5%E7%B6%9A

## 初回設定
```
sudo raspi-config
```
- Interface Optionsを選択
- Legacy CameraをYesに設定

再起動
```
sudo reboot
```

```
vcgencmd get_camera
```
以下の通りなっていたらＯＫ
> supported=1 detected=0, libcamera interfaces=0
```

sudo nano /boot/config.txt
```
最終行に以下を追記
> dtoverlay=imx219
Ctrl+O Enter Ctrl+X
```
cd ~
git clone https://github.com/darts-cloud/raspi_setup.git
cd raspi_setup
./run.sh
```

## 初回設定
https://qiita.com/zono_0/items/43fc89876977738de402


```
sudo vi /etc/rc.local
```
- 以下を追記
> /usr/local/bin/v4l2rtspserver -W 1280 -H 720 -F 60
