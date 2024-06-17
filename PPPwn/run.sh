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

#Correct FW for pppwn, if no goldhen it will use normal pppwn
#prepare for hen-vtx.
if [[ $FIRMWAREVERSION == "10.50" || $FIRMWAREVERSION == "10.70" || $FIRMWAREVERSION == "10.71" ]] ;then
STAGE1FW="10.50"
STAGE2FW="10.50"
elif [[ $FIRMWAREVERSION == "10.00" || $FIRMWAREVERSION == "10.01" ]] ;then
STAGE1FW="10.00"
STAGE2FW="10.00"
elif [[ $FIRMWAREVERSION == "9.50" || $FIRMWAREVERSION == "9.51" || $FIRMWAREVERSION == "9.60" ]] ;then
STAGE1FW="9.50"
STAGE2FW="9.50"
elif [[ $FIRMWAREVERSION == "9.03" || $FIRMWAREVERSION == "9.04" ]] ;then
STAGE1FW="9.03"
STAGE2FW="9.03"
elif [[ $FIRMWAREVERSION == "9.00" ]] ;then
STAGE1FW="9.00"
STAGE2FW="9.00"
elif [[ $FIRMWAREVERSION == "8.50" || $FIRMWAREVERSION == "8.52" ]] ;then
STAGE1FW="8.50"
STAGE2FW="8.50"
elif [[ $FIRMWAREVERSION == "8.00" || $FIRMWAREVERSION == "8.01" || $FIRMWAREVERSION == "8.03" ]] ;then
STAGE1FW="8.00"
STAGE2FW="8.00"
elif [[ $FIRMWAREVERSION == "7.50" || $FIRMWAREVERSION == "7.51" || $FIRMWAREVERSION == "7.55" ]] ;then
STAGE1FW="7.50"
STAGE2FW="7.50"
elif [[ $FIRMWAREVERSION == "7.00" || $FIRMWAREVERSION == "7.01" || $FIRMWAREVERSION == "7.02" ]] ;then
STAGE1FW="7.00"
STAGE2FW="7.00"
else
STAGE1FW="11.00"
STAGE2FW="11.00"
fi

if [ $USBETHERNET = true ] ; then
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind
fi

PITYP=$(tr -d '\0' </proc/device-tree/model) 
if [[ $PITYP == *"Raspberry Pi 2"* ]] ;then
coproc read -t 15 && wait "$!" || true
CPPBIN="pppwn7"
elif [[ $PITYP == *"Raspberry Pi 3"* ]] ;then
coproc read -t 10 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi 4"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi 5"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi Zero 2"* ]] ;then
coproc read -t 8 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi Zero"* ]] ;then
coproc read -t 10 && wait "$!" || true
CPPBIN="pppwn11"
elif [[ $PITYP == *"Raspberry Pi"* ]] ;then
coproc read -t 15 && wait "$!" || true
CPPBIN="pppwn11"
else
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
fi
arch=$(getconf LONG_BIT)
if [ $arch -eq 32 ] && [ $CPPBIN = "pppwn64" ] ; then
CPPBIN="pppwn7"
fi

#IPv6 improved curse ps4 or IPv4
if [ $USEIPV6 = false ] ; then
CPPBIN+='v1'
fi

echo -e "\n\n\033[36m _____  _____  _____                 
|  __ \\|  __ \\|  __ \\
| |__) | |__) | |__) |_      ___ __
|  ___/|  ___/|  ___/\\ \\ /\\ / / '_ \\
| |    | |    | |     \\ V  V /| | | |
|_|    |_|    |_|      \\_/\\_/ |_| |_|\033[0m
\n\033[33mhttps://github.com/TheOfficialFloW/PPPwn\033[0m\n" | sudo tee /dev/tty1

echo -e "\033[37mGoldhen by      : SiSTR0\033[0m" | sudo tee /dev/tty1
echo -e "\033[37mOriginal Script : Stooged\033[0m" | sudo tee /dev/tty1
echo -e "\033[37mC++ Port        : xfangfang\033[0m" | sudo tee /dev/tty1
echo -e "\033[37mMod By          : joe97tab\033[0m" | sudo tee /dev/tty1

sudo systemctl stop pppoe
if [ $USBETHERNET = true ] ; then
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
	coproc read -t 2 && wait "$!" || true
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind
	coproc read -t 5 && wait "$!" || true
	sudo ip link set $INTERFACE up
else
	sudo ip link set $INTERFACE down
	coproc read -t 5 && wait "$!" || true
	sudo ip link set $INTERFACE up
fi

echo -e "\n\033[36m$PITYP\033[92m\nFirmware:\033[93m $FIRMWAREVERSION\033[92m\nInterface:\033[93m $INTERFACE\033[0m" | sudo tee /dev/tty1

echo -e "\033[92mPPPwn:\033[93m C++ $CPPBIN \033[0m" | sudo tee /dev/tty1

echo -e "\033[95mReady for console connection\033[0m" | sudo tee /dev/tty1

while [ true ]
do
while read -r stdo ; 
do 
 if [[ $stdo  == "[+] Done!" ]] ; then
	echo -e "\033[32m\nConsole PPPwned! \033[0m\n" | sudo tee /dev/tty1
    if [ $SHUTDOWN = true ] ; then
     sudo poweroff
    else
     sudo ip link set $INTERFACE down
    fi
	exit 0
 elif [[ $stdo  == *"Scanning for corrupted object...failed"* ]] ; then
 	echo -e "\033[31m\nFailed retrying...\033[0m\n" | sudo tee /dev/tty1
 elif [[ $stdo  == *"Unsupported firmware version"* ]] ; then
 	echo -e "\033[31m\nUnsupported firmware version\033[0m\n" | sudo tee /dev/tty1
 	exit 1
 elif [[ $stdo  == *"Cannot find interface with name of"* ]] ; then
 	echo -e "\033[31m\nInterface $INTERFACE not found\033[0m\n" | sudo tee /dev/tty1
 	exit 1
 fi
done < <(timeout $TIMEOUT sudo /boot/firmware/PPPwn/$CPPBIN --interface "$INTERFACE" --fw "${STAGE1FW//.}" --stage1 "/boot/firmware/PPPwn/stage1_$STAGE1FW.bin" --stage2 "/boot/firmware/PPPwn/stage2_$STAGE2FW.bin")
coproc read -t 1 && wait "$!" || true
done