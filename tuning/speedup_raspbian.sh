#!/bin/bash

#Fine tuning for raspbian os.
#It will reduced the boot process around 6-10 seconds depend on distribution.
#Also increase overall performance and pwn success rate.

#Bullseye had some problem with dhcpd, slow boot process.

#To check boot time.
#systemd-analyze time

#To check service time.
#systemd-analyze blame

initial_turbo=30

sudo systemctl disable bluetooth
sudo systemctl disable hciuart.service
sudo systemctl disable raspi-config
sudo systemctl disable triggerhappy
sudo systemctl disable apt-daily
sudo systemctl disable apt-daily-upgrade
sudo systemctl disable keyboard-setup
sudo systemctl disable rsyslog
sudo systemctl disable logrotate
sudo systemctl disable man-db
sudo systemctl disable avahi-daemon
sudo systemctl disable rpi-eeprom-update
sudo systemctl disable dphys-swapfile
sudo chmod -x /etc/init.d/dphys-swapfile
sudo swapoff -a
sudo rm /var/swap

echo -e '\033[37mFine tuning complete\033[0m'

#sudo reboot
