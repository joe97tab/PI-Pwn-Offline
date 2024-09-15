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
sudo rm -rf /boot/firmware/PPPwn/
sudo tar -xf /boot/firmware/update/PPPwn.tar -C /boot/firmware/
sudo chmod 777 /boot/firmware/PPPwn/*.*
sudo rm -rf /boot/firmware/update/

echo 'auth
lcp-echo-failure 3
lcp-echo-interval 60
mtu 1482
mru 1482
noauth
ms-dns 192.168.2.1
netmask 255.255.255.0
defaultroute
noipdefault' | sudo tee /etc/ppp/pppoe-server-options

HSTN="pppwn"
CHSTN=$(hostname | cut -f1 -d' ')
sudo sed -i "s^$CHSTN^$HSTN^g" /etc/hosts
sudo sed -i "s^$CHSTN^$HSTN^g" /etc/hostname
sudo sed -i "/^dns=.*/d" /etc/NetworkManager/NetworkManager.conf
sudo sed -i "/^rc-manager=.*/d" /etc/NetworkManager/NetworkManager.conf
sudo sed -i "2i dns=none" /etc/NetworkManager/NetworkManager.conf
sudo sed -i "3i rc-manager=unmanaged" /etc/NetworkManager/NetworkManager.conf
echo 'nameserver 192.168.2.1
nameserver 127.0.0.1' | sudo tee /etc/resolv.conf.manually-configured
sudo rm /etc/resolv.conf
sudo ln -s /etc/resolv.conf.manually-configured /etc/resolv.conf
echo '[keyfile]
unmanaged-devices=type:wifi' | sudo tee /etc/NetworkManager/conf.d/99-unmanaged-devices.conf
sudo systemctl restart network-manager

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