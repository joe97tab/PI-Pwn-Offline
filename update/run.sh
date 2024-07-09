#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi
if [ -f /boot/firmware/PPPwn/pconfig.sh ]; then
source /boot/firmware/PPPwn/pconfig.sh
fi

if [ -z $CPPMETHOD ]; then CPPMETHOD="xfangfang"; fi
if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi
if [ -z $STAGE2METHOD ]; then STAGE2METHOD="flow"; fi
if [ -z $USEIPV6 ]; then USEIPV6=false; fi

if [ -z $XFWAP ]; then XFWAP="1"; fi
if [ -z $XFGD ]; then XFGD="4"; fi
if [ -z $XFBS ]; then XFBS="0"; fi
if [ -z $XFNWB ]; then XFNWB=false; fi

sudo mkdir /boot/firmware/update/
sudo mv /boot/firmware/PPPwn/PPPwn.tar /boot/firmware/update/PPPwn.tar
sudo rm -rf /boot/firmware/PPPwn/
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/
sudo chmod 777 /boot/firmware/PPPwn/*.*
sudo rm -rf /boot/firmware/update/

# creat general config
echo '#!/bin/bash
CPPMETHOD="'$CPPMETHOD'"
INTERFACE="'$INTERFACE'"
FIRMWAREVERSION="'$FIRMWAREVERSION'"
USBETHERNET='$USBETHERNET'
STAGE2METHOD="'$STAGE2METHOD'"
USEIPV6='$USEIPV6'' | sudo tee /boot/firmware/PPPwn/config.sh

# create pppwn c++ config
echo '#!/bin/bash
XFWAP="'$XFWAP'"
XFGD="'$XFGD'"
XFBS="'$XFBS'"
XFNWB='$XFNWB'' | sudo tee /boot/firmware/PPPwn/pconfig.sh

coproc read -t 2 && wait "$!" || true
sudo reboot