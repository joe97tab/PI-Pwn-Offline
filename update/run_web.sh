#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi
if [ -f /boot/firmware/PPPwn/pconfig.sh ]; then
source /boot/firmware/PPPwn/pconfig.sh
fi

if [ -z $CPPMETHOD ]; then CPPMETHOD="3"; fi
if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi
if [ -z $STAGE2METHOD ]; then STAGE2METHOD="flow"; fi
if [ -z $NEWIPV6 ]; then NEWIPV6=true; fi
if [ -z $DELAYSTART ]; then DELAYSTART="0"; fi

if [ -z $PPPOECONN ]; then PPPOECONN=true; fi
if [ -z $PWNAUTORUN ]; then PWNAUTORUN=false; fi
if [ -z $TIMEOUT ]; then TIMEOUT="5m"; fi
if [ -z $PPDBG ]; then PPDBG=false; fi

if [ -z $XFWAP ]; then XFWAP="1"; fi
if [ -z $XFGD ]; then XFGD="4"; fi
if [ -z $XFBS ]; then XFBS="0"; fi
if [ -z $XFNWB ]; then XFNWB=false; fi
if [ -z $SPRAY_NUM ]; then SPRAY_NUM="1000"; fi
if [ -z $CORRUPT_NUM ]; then CORRUPT_NUM="1"; fi
if [ -z $PIN_NUM ]; then PIN_NUM="1000"; fi

sudo mkdir /boot/firmware/update/
sudo mv /boot/firmware/PPPwn/PPPwn.tar /boot/firmware/update/PPPwn.tar
if [ -f /boot/firmware/PPPwn/pppoelogin.txt ]; then
sudo mv /boot/firmware/PPPwn/pppoelogin.txt /boot/firmware/update/pppoelogin.txt
fi
sudo rm -rf /boot/firmware/PPPwn/
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/
if [ -f /boot/firmware/update/pppoelogin.txt ]; then
sudo mv /boot/firmware/update/pppoelogin.txt /boot/firmware/PPPwn/pppoelogin.txt
fi
sudo chmod 777 /boot/firmware/PPPwn/*.*
sudo rm -rf /boot/firmware/update/

if [[ ${STAGE2METHOD,,} == "hen" ]] || [[ ${STAGE2METHOD,,} == *"vtx"* ]] ;then
if [ -f /boot/firmware/PPPwn/stage2/goldhen/stage2_${FIRMWAREVERSION//.}.bin ] ; then
STAGE2METHOD="goldhen"
fi
fi

# create general config
echo '#!/bin/bash
CPPMETHOD="'${CPPMETHOD/ /}'"
INTERFACE="'${INTERFACE/ /}'"
FIRMWAREVERSION="'${FIRMWAREVERSION/ /}'"
USBETHERNET='$USBETHERNET'
STAGE2METHOD="'${STAGE2METHOD/ /}'"
NEWIPV6='$NEWIPV6'
DELAYSTART="'${DELAYSTART/ /}'"
PPPOECONN='$PPPOECONN'
PWNAUTORUN='$PWNAUTORUN'
TIMEOUT="'${TIMEOUT/ /}'"
PPDBG='$PPDBG'' | sudo tee /boot/firmware/PPPwn/config.sh

# create pppwn c++ config
echo '#!/bin/bash
XFWAP="'${XFWAP/ /}'"
XFGD="'${XFGD/ /}'"
XFBS="'${XFBS/ /}'"
XFNWB='$XFNWB'
SPRAY_NUM="'${SPRAY_NUM/ /}'"
CORRUPT_NUM="'${CORRUPT_NUM/ /}'"
PIN_NUM="'${PIN_NUM/ /}'"' | sudo tee /boot/firmware/PPPwn/pconfig.sh

coproc read -t 4 && wait "$!" || true

sudo systemctl restart pipwn