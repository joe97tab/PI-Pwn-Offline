#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi

if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi

sudo mkdir /boot/firmware/update/
sudo mv /boot/firmware/PPPwn/PPPwn.tar /boot/firmware/update/PPPwn.tar
sudo rm -rf /boot/firmware/PPPwn/
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/
sudo chmod 777 /boot/firmware/PPPwn/*.*
sudo rm -rf /boot/firmware/update/

# write config
echo '#!/bin/bash
INTERFACE="'$INTERFACE'"
FIRMWAREVERSION="'$FIRMWAREVERSION'"
USBETHERNET='$USBETHERNET'' | sudo tee /boot/firmware/PPPwn/config.sh

coproc read -t 2 && wait "$!" || true
sudo reboot