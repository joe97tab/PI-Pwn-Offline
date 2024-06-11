#!/bin/bash

#Fine tuning for armbian os.
#It will reduced the boot process around 6-10 seconds depend on distribution.
#Also increase overall performance and pwn success rate.
#Is Ubuntu use more power (watt) than Debian?
#I found it hard to boot from ps4 usb with Ubuntu (Noble).

#Tested on : Stretch, Buster, Bullseye, Bookworm, Jammy.

#To check boot time.
#systemd-analyze time

#To check service time.
#systemd-analyze blame

sudo systemctl disable armbian-ramlog
sudo systemctl disable armbian-zram-config
sudo systemctl disable armbian-hardware-monitor
sudo systemctl disable armbian-hardware-optimize
sudo systemctl disable NetworkManager-wait-online
sudo systemctl disable fake-hwclock
sudo systemctl disable rsyslog
sudo systemctl disable keyboard-setup
#New distribution.
sudo systemctl disable e2scrub_reap
#Old distribution, stretch, buster.
sudo systemctl disable ntp

#To check cpu frequency.
#cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies

#Modify cpufrequtils, setting value depend on your cpu.
echo 'ENABLE=true
MIN_SPEED=1296000
MAX_SPEED=1510000
GOVERNOR=performance' | sudo tee /etc/default/cpufrequtils

#Restore default network interfaces
#sudo cp /etc/network/interfaces.default /etc/network/interfaces

echo -e '\033[37mFine tuning complete\033[0m'

#sudo reboot
