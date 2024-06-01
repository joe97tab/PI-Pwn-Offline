#!/bin/bash

if [ -f /boot/firmware/PPPwn/config.sh ]; then
source /boot/firmware/PPPwn/config.sh
fi
if [ -z $INTERFACE ]; then INTERFACE="eth0"; fi
if [ -z $FIRMWAREVERSION ]; then FIRMWAREVERSION="11.00"; fi
if [ -z $SHUTDOWN ]; then SHUTDOWN=true; fi
if [ -z $USBETHERNET ]; then USBETHERNET=false; fi
if [ -z $PPPOECONN ]; then PPPOECONN=false; fi
if [ -z $VMUSB ]; then VMUSB=false; fi
if [ -z $DTLINK ]; then DTLINK=false; fi
if [ -z $PPDBG ]; then PPDBG=false; fi
if [ -z $TIMEOUT ]; then TIMEOUT="5m"; fi
if [ -z $RESTMODE ]; then RESTMODE=false; fi
if [ -z $PYPWN ]; then PYPWN=false; fi
if [ -z $LEDACT ]; then LEDACT="normal"; fi
if [ $PYPWN = true ] ; then
sudo bash /boot/firmware/PPPwn/runpy.sh
exit 0
fi
PITYP=$(tr -d '\0' </proc/device-tree/model) 
if [[ $PITYP == *"Raspberry Pi 2"* ]] ;then
coproc read -t 15 && wait "$!" || true
CPPBIN="pppwn7"
VMUSB=false
elif [[ $PITYP == *"Raspberry Pi 3"* ]] ;then
coproc read -t 10 && wait "$!" || true
CPPBIN="pppwn64"
VMUSB=false
elif [[ $PITYP == *"Raspberry Pi 4"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi 5"* ]] ;then
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
elif [[ $PITYP == *"Raspberry Pi Zero 2"* ]] ;then
coproc read -t 8 && wait "$!" || true
CPPBIN="pppwn64"
VMUSB=false
elif [[ $PITYP == *"Raspberry Pi Zero"* ]] ;then
coproc read -t 10 && wait "$!" || true
CPPBIN="pppwn11"
VMUSB=false
elif [[ $PITYP == *"Raspberry Pi"* ]] ;then
coproc read -t 15 && wait "$!" || true
CPPBIN="pppwn11"
VMUSB=false
else
coproc read -t 5 && wait "$!" || true
CPPBIN="pppwn64"
VMUSB=false
fi
arch=$(getconf LONG_BIT)
if [ $arch -eq 32 ] && [ $CPPBIN = "pppwn64" ] && [[ ! $PITYP == *"Raspberry Pi 4"* ]] && [[ ! $PITYP == *"Raspberry Pi 5"* ]] ; then
CPPBIN="pppwn7"
fi
if [[ $LEDACT == "status" ]] || [[ $LEDACT == "off" ]] ;then
   echo none | sudo tee /sys/class/leds/ACT/trigger >/dev/null
   echo none | sudo tee /sys/class/leds/PWR/trigger >/dev/null
fi
echo -e "\n\n\033[36m _____  _____  _____                               
|  __ \\|  __ \\|  __ \\                    _     _   
| |__) | |__) | |__) |_      ___ __    _| |_ _| |_ 
|  ___/|  ___/|  ___/\\ \\ /\\ / / '_ \\  |_   _|_   _|
| |    | |    | |     \\ V  V /| | | |   |_|   |_|  
|_|    |_|    |_|      \\_/\\_/ |_| |_|\033[0m
\n\033[33mhttps://github.com/TheOfficialFloW/PPPwn\nhttps://github.com/xfangfang/PPPwn_cpp\033[0m\n" | sudo tee /dev/tty1
sudo systemctl stop pppoe
sudo systemctl stop dtlink
if [ $USBETHERNET = true ] ; then
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind >/dev/null
	coproc read -t 1 && wait "$!" || true
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind >/dev/null
	coproc read -t 4 && wait "$!" || true
	sudo ip link set $INTERFACE up
   else	
	sudo ip link set $INTERFACE down
	coproc read -t 5 && wait "$!" || true
	sudo ip link set $INTERFACE up
fi
echo -e "\n\033[36m$PITYP\033[92m\nFirmware:\033[93m $FIRMWAREVERSION\033[92m\nInterface:\033[93m $INTERFACE\033[0m" | sudo tee /dev/tty1
echo -e "\033[92mPPPwn:\033[93m C++ $CPPBIN \033[0m" | sudo tee /dev/tty1
if [ $VMUSB = true ] ; then
 sudo rmmod g_mass_storage
  FOUND=0
  readarray -t rdirarr  < <(sudo ls /media/pwndrives)
  for rdir in "${rdirarr[@]}"; do
    readarray -t pdirarr  < <(sudo ls /media/pwndrives/${rdir})
    for pdir in "${pdirarr[@]}"; do
       if [[ ${pdir,,}  == "payloads" ]] ; then 
	     FOUND=1
	     UDEV='/dev/'${rdir}
	     break
      fi
    done
      if [ "$FOUND" -ne 0 ]; then
        break
      fi
  done  
  if [[ ! -z $UDEV ]] ;then
    sudo modprobe g_mass_storage file=$UDEV stall=0 ro=0 removable=1
  fi
  echo -e "\033[92mUSB Drive:\033[93m Enabled\033[0m" | sudo tee /dev/tty1
fi
if [ $PPPOECONN = true ] ; then
   echo -e "\033[92mInternet Access:\033[93m Enabled\033[0m" | sudo tee /dev/tty1
else   
   echo -e "\033[92mInternet Access:\033[93m Disabled\033[0m" | sudo tee /dev/tty1
fi
if [ -f /boot/firmware/PPPwn/pwn.log ]; then
   sudo rm -f /boot/firmware/PPPwn/pwn.log
fi
if [[ $LEDACT == "status" ]] ;then
   echo timer | sudo tee /sys/class/leds/PWR/trigger >/dev/null
fi
if [[ ! $(ethtool $INTERFACE) == *"Link detected: yes"* ]]; then
   echo -e "\033[31mWaiting for link\033[0m" | sudo tee /dev/tty1
   while [[ ! $(ethtool $INTERFACE) == *"Link detected: yes"* ]]
   do
      coproc read -t 2 && wait "$!" || true
   done
   echo -e "\033[32mLink found\033[0m\n" | sudo tee /dev/tty1
fi
if [ $RESTMODE = true ] ; then
sudo pppoe-server -I $INTERFACE -T 60 -N 1 -C PPPWN -S PPPWN -L 192.168.2.1 -R 192.168.2.2 
coproc read -t 2 && wait "$!" || true
while [[ $(sudo nmap -p 3232 192.168.2.2 | grep '3232/tcp' | cut -f2 -d' ') == "" ]]
do
    coproc read -t 2 && wait "$!" || true
done
coproc read -t 5 && wait "$!" || true
GHT=$(sudo nmap -p 3232 192.168.2.2 | grep '3232/tcp' | cut -f2 -d' ')
if [[ $GHT == *"open"* ]] ; then
echo -e "\n\033[95mGoldhen found aborting pppwn\033[0m\n" | sudo tee /dev/tty1
if [[ $LEDACT == "status" ]] ;then
	echo none | sudo tee /sys/class/leds/PWR/trigger >/dev/null
	echo default-on | sudo tee /sys/class/leds/ACT/trigger >/dev/null
fi
sudo killall pppoe-server
if [ $PPPOECONN = true ] ; then
	sudo systemctl start pppoe
	if [ $DTLINK = true ] ; then
		sudo systemctl start dtlink
	fi
else
	if [ $SHUTDOWN = true ] ; then
		coproc read -t 5 && wait "$!" || true
		sudo poweroff
	else
		if [ $DTLINK = true ] ; then
			sudo systemctl start dtlink
		else
			sudo ip link set $INTERFACE down
		fi
	fi
fi
exit 0
else
echo -e "\n\033[95mGoldhen not found starting pppwn\033[0m\n" | sudo tee /dev/tty1
sudo killall pppoe-server
if [ $USBETHERNET = true ] ; then
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind >/dev/null
	coproc read -t 1 && wait "$!" || true
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind >/dev/null
	coproc read -t 4 && wait "$!" || true
	sudo ip link set $INTERFACE up
   else	
	sudo ip link set $INTERFACE down
	coproc read -t 5 && wait "$!" || true
	sudo ip link set $INTERFACE up
fi
fi
fi
if [[ $FIRMWAREVERSION == "10.00" ]] || [[ $FIRMWAREVERSION == "10.01" ]] ;then
STAGEVER="10.00"
elif [[ $FIRMWAREVERSION == "9.00" ]] ;then
STAGEVER="9.00"
else
STAGEVER="11.00"
fi
PIIP=$(hostname -I) || true
if [ "$PIIP" ]; then
   echo -e "\n\033[92mIP: \033[93m $PIIP\033[0m" | sudo tee /dev/tty1
fi
echo -e "\n\033[95mReady for console connection\033[0m\n" | sudo tee /dev/tty1
while [ true ]
do
if [[ $LEDACT == "status" ]] ;then
	echo heartbeat | sudo tee /sys/class/leds/PWR/trigger >/dev/null
	echo timer | sudo tee /sys/class/leds/ACT/trigger >/dev/null
fi
if [ -f /boot/firmware/PPPwn/config.sh ]; then
 if  grep -Fxq "PPDBG=true" /boot/firmware/PPPwn/config.sh ; then
   PPDBG=true
   else
   PPDBG=false
 fi
fi
while read -r stdo ; 
do 
 if [ $PPDBG = true ] ; then
	echo -e $stdo | sudo tee /dev/tty1 | sudo tee /dev/pts/* | sudo tee -a /boot/firmware/PPPwn/pwn.log
 fi
 if [[ $stdo  == "[+] Done!" ]] ; then
	echo -e "\033[32m\nConsole PPPwned! \033[0m\n" | sudo tee /dev/tty1
	if [[ $LEDACT == "status" ]] ;then
		echo none | sudo tee /sys/class/leds/PWR/trigger >/dev/null
		echo default-on | sudo tee /sys/class/leds/ACT/trigger >/dev/null
	fi
	if [ $PPPOECONN = true ] ; then
		sudo systemctl start pppoe
		if [ $DTLINK = true ] ; then
			sudo systemctl start dtlink
		fi
	else
		if [ $SHUTDOWN = true ] ; then
			coproc read -t 5 && wait "$!" || true
			sudo poweroff
		else
			if [ $DTLINK = true ] ; then
				sudo systemctl start dtlink
			else
				sudo ip link set $INTERFACE down
			fi
        fi
	fi
	exit 0
 elif [[ $stdo  == *"Scanning for corrupted object...failed"* ]] ; then
 	echo -e "\033[31m\nFailed retrying...\033[0m\n" | sudo tee /dev/tty1
 elif [[ $stdo  == *"Unsupported firmware version"* ]] ; then
 	echo -e "\033[31m\nUnsupported firmware version\033[0m\n" | sudo tee /dev/tty1
	
	if [[ $LEDACT == "status" ]] ;then
	 	echo none | sudo tee /sys/class/leds/ACT/trigger >/dev/null
	 	echo default-on | sudo tee /sys/class/leds/PWR/trigger >/dev/null
	fi
 	exit 1
 elif [[ $stdo  == *"Cannot find interface with name of"* ]] ; then
 	echo -e "\033[31m\nInterface $INTERFACE not found\033[0m\n" | sudo tee /dev/tty1
	
	if [[ $LEDACT == "status" ]] ;then
	 	echo none | sudo tee /sys/class/leds/ACT/trigger >/dev/null
	 	echo default-on | sudo tee /sys/class/leds/PWR/trigger >/dev/null
	fi
 	exit 1
 fi
done < <(timeout $TIMEOUT sudo /boot/firmware/PPPwn/$CPPBIN --interface "$INTERFACE" --fw "${STAGEVER//.}" --stage1 "/boot/firmware/PPPwn/stage1_$STAGEVER.bin" --stage2 "/boot/firmware/PPPwn/stage2_$STAGEVER.bin")
if [[ $LEDACT == "status" ]] ;then
 	echo none | sudo tee /sys/class/leds/ACT/trigger >/dev/null
 	echo default-on | sudo tee /sys/class/leds/PWR/trigger >/dev/null
fi
sudo ip link set $INTERFACE down
coproc read -t 3 && wait "$!" || true
sudo ip link set $INTERFACE up
done