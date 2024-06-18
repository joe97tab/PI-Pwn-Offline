#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi
#eth0, eth1, end0, etc.
if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
#[7.00, 7.01, 7.02] [7.50, 7.51, 7.55] [8.00, 8.01, 8.03] [8.50, 8.52] 9.00 [9.03, 9.04] [9.50, 9.51, 9.60] [10.00, 10.01] [10.50, 10.70, 10.71] 11.00
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi
if [ -z $USEIPV6 ]; then USEIPV6=true; fi
if [ -z $TIMEOUT ]; then TIMEOUT="5m"; fi

#Correct FW for pppwn
if [[ $FIRMWAREVERSION == "7.00" ]] || [[ $FIRMWAREVERSION == "7.01" ]] || [[ $FIRMWAREVERSION == "7.02" ]] ;then
STAGEVER="7.00"
elif [[ $FIRMWAREVERSION == "7.50" ]] || [[ $FIRMWAREVERSION == "7.51" ]] || [[ $FIRMWAREVERSION == "7.55" ]] ;then
STAGEVER="7.50"
elif [[ $FIRMWAREVERSION == "8.00" ]] || [[ $FIRMWAREVERSION == "8.01" ]] || [[ $FIRMWAREVERSION == "8.03" ]] ;then
STAGEVER="8.00"
elif [[ $FIRMWAREVERSION == "8.50" ]] || [[ $FIRMWAREVERSION == "8.52" ]] ;then
STAGEVER="8.50"
elif [[ $FIRMWAREVERSION == "9.00" ]] ;then
STAGEVER="9.00"
elif [[ $FIRMWAREVERSION == "9.03" ]] || [[ $FIRMWAREVERSION == "9.04" ]] ;then
STAGEVER="9.03"
elif [[ $FIRMWAREVERSION == "9.50" ]] || [[ $FIRMWAREVERSION == "9.51" ]] || [[ $FIRMWAREVERSION == "9.60" ]] ;then
STAGEVER="9.50"
elif [[ $FIRMWAREVERSION == "10.00" ]] || [[ $FIRMWAREVERSION == "10.01" ]] ;then
STAGEVER="10.00"
elif [[ $FIRMWAREVERSION == "10.50" ]] || [[ $FIRMWAREVERSION == "10.70" ]] || [[ $FIRMWAREVERSION == "10.71" ]] ;then
STAGEVER="10.50"
else
STAGEVER="11.00"
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
if [ $arch -eq 32 ] && [ $CPPBIN = "pppwn64" ] && [[ ! $PITYP == *"Raspberry Pi 4"* ]] && [[ ! $PITYP == *"Raspberry Pi 5"* ]] ; then
CPPBIN="pppwn7"
fi

#IPv6 improved curse ps4 or IPv4
if [ $USEIPV6 = false ]; then CPPBIN+='v1'; fi

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
if [[ $stdo  == "[+] Done!" ]] ;then
coproc read -t 6 && wait "$!" || true
sudo poweroff
fi
done < <(timeout $TIMEOUT sudo /boot/firmware/PPPwn/$CPPBIN --interface "$INTERFACE" --fw "${STAGEVER//.}" --stage1 "/boot/firmware/PPPwn/stage1_$STAGEVER.bin" --stage2 "/boot/firmware/PPPwn/stage2_$STAGEVER.bin")
coproc read -t 1 && wait "$!" || true
done