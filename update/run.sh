#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi

#[7.00, 7.01, 7.02] [7.50, 7.51, 7.55] [8.00, 8.01, 8.03] [8.50, 8.52] 9.00 [9.03, 9.04] [9.50, 9.51, 9.60] [10.00, 10.01] [10.50, 10.70, 10.71] 11.00

if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi

sudo mkdir /boot/firmware/update/
sudo mv /boot/firmware/PPPwn/PPPwn.tar /boot/firmware/update/PPPwn.tar
sudo rm /boot/firmware/PPPwn/*.*
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/PPPwn/
sudo chmod 777 /boot/firmware/PPPwn/*.*
sudo rm -rf /boot/firmware/update/

# creat general config
echo '#!/bin/bash
INTERFACE="'$INTERFACE'"
FIRMWAREVERSION="'$FIRMWAREVERSION'"
USBETHERNET='$USBETHERNET'' | sudo tee /boot/firmware/PPPwn/config.sh

# create pppwn c++ config
echo '#!/bin/bash
XFWAP="1"
XFGD="4"
XFBS="0"
XFNWB=true' | sudo tee /boot/firmware/PPPwn/pconfig.sh

coproc read -t 1 && wait "$!" || true
sudo reboot