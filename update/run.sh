#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi
#eth0, eth1, end0, etc.
if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
#[7.00, 7.01, 7.02] [7.50, 7.51, 7.55] [8.00, 8.01, 8.03] [8.50, 8.52] 9.00 [9.03, 9.04] [9.50, 9.51, 9.60] [10.00, 10.01] [10.50, 10.70, 10.71] 11.00
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $SHUTDOWN ]; then SHUTDOWN=true; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi
if [ -z $USEIPV6 ]; then USEIPV6=false; fi
if [ -z $USEGOLDHEN ]; then USEGOLDHEN=true; fi
if [ -z $TIMEOUT ]; then TIMEOUT="5m"; fi

sudo mkdir /boot/firmware/update/
sudo mv /boot/firmware/PPPwn/PPPwn.tar /boot/firmware/update/PPPwn.tar
sudo rm /boot/firmware/PPPwn/*.*
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/PPPwn/
sudo rm -rf /boot/firmware/update/

# write config
echo '#!/bin/bash
INTERFACE="'$INTERFACE'"
FIRMWAREVERSION="'$FIRMWAREVERSION'"
USBETHERNET='$USBETHERNET'
SHUTDOWN='$SHUTDOWN'
USEIPV6='$USEIPV6'
USEGOLDHEN='$USEGOLDHEN'' | sudo tee /boot/firmware/PPPwn/config.sh

sudo reboot