#!/bin/bash

# Offline Mode, Auto Shutdown & C++

echo -e ''
echo -e '\033[37mPPPwn PS4 Jailbreak : Offline Mode, Auto Shutdown and C++\033[0m'
echo -e '\033[37mPPPwn by            : FloW\033[0m'
echo -e '\033[37mGoldhen by          : SiSTR0\033[0m'
echo -e '\033[37mOriginal Script     : Stooged\033[0m'
echo -e '\033[37mC++ Port            : xfangfang\033[0m'
echo -e '\033[37mMod By              : joe97tab\033[0m'

while true; do
read -p "$(printf '\r\n\r\n\033[37mAre you using a usb to ethernet adapter for the console connection\r\n\r\n\033[37m(Y|N)?: \033[0m')" usbeth
case $usbeth in
[Yy]* ) 
USBE="true"
echo -e '\033[33mUsb to ethernet is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\033[32mUsb to ethernet is NOT being used\033[0m'
USBE="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done

while true; do
read -p "$(printf '\r\n\r\n\033[37mWould you like to change the firmware version being used, the default is 11.00\r\n\r\n\033[37m(Y|N)?: \033[0m')" fwset
case $fwset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[37mEnter the firmware version [ 7.00 | 7.01 | 7.02 | 7.50 | 7.51 | 7.55 | 8.00 | 8.01 | 8.03 | 8.50 | 8.52 | 9.00 | 9.03 | 9.04 | 9.50 | 9.51 | 9.60 | 10.00 | 10.01 | 10.50 | 10.70 | 10.71 | 11.00 ]: \033[0m')" FWV
case $FWV in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[0-9.]*$' <<<$FWV ; then 

if [[ ! "$FWV" =~ ^("7.00"|"7.01"|"7.02"|"7.50"|"7.51"|"7.55"|"8.00"|"8.01"|"8.03"|"8.50"|"8.52"|"9.00"|"9.03"|"9.04"|"9.50"|"9.51"|"9.60"|"10.00"|"10.01"|"10.50"|"10.70"|"10.71"|"11.00")$ ]]  ; then
echo -e '\033[31mThe version must be [ 7.00 | 7.01 | 7.02 | 7.50 | 7.51 | 7.55 | 8.00 | 8.01 | 8.03 | 8.50 | 8.52 | 9.00 | 9.03 | 9.04 | 9.50 | 9.51 | 9.60 | 10.00 | 10.01 | 10.50 | 10.70 | 10.71 | 11.00 ]\033[0m';
else 
break;
fi
else 
echo -e '\033[31mThe version must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\033[33mYou are using '$FWV'\033[0m'
break;;
[Nn]* ) 
echo -e '\033[32mUsing the default setting: 11.00\033[0m'
FWV="11.00"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done

echo -e ''
ip link

while true; do
read -p "$(printf '\r\n\r\n\033[37mWould you like to change the lan interface, the default is eth0\r\n\r\n\033[37m(Y|N)?: \033[0m')" ifset
case $ifset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[37mEnter the interface value: \033[0m')" IFCE
case $IFCE in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[0-9a-zA-Z_ -]*$' <<<$IFCE ; then 
if [ ${#IFCE} -le 1 ]  || [ ${#IFCE} -ge 17 ] ; then
echo -e '\033[31mThe interface must be between 2 and 16 characters long\033[0m';
else 
break;
fi
else 
echo -e '\033[31mThe interface must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\033[33mYou are using '$IFCE'\033[0m'
break;;
[Nn]* ) 
echo -e '\033[32mUsing the default setting: eth0\033[0m'
IFCE="eth0"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done

echo -e '\033[37mIPv6 slower than IPv4, no need to using IPv6 if pwn work\033[0m'
while true; do
read -p "$(printf '\r\n\r\n\033[37mAre you using IPv6 for pwn, it will improve curse PS4\r\n\r\n\033[37m(Y|N)?: \033[0m')" useipv
case $useipv in
[Yy]* ) 
IPV6STATE="true"
echo -e '\033[32mIPv6 is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\033[33mIPv4 is being used\033[0m'
IPV6STATE="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done

# create general config
echo '#!/bin/bash
INTERFACE="'$IFCE'"
FIRMWAREVERSION="'$FWV'"
USBETHERNET='$USBE'
USEIPV6='$IPV6STATE'' | sudo tee /boot/firmware/PPPwn/config.sh

# create pppwn c++ config
echo '#!/bin/bash
XFWAP="1"
XFGD="4"
XFBS="0"
XFNWB=false' | sudo tee /boot/firmware/PPPwn/pconfig.sh

sudo rm /usr/lib/systemd/system/bluetooth.target
sudo rm /usr/lib/systemd/system/network-online.target
sudo sed -i 's^sudo bash /boot/firmware/PPPwn/run.sh \&^^g' /etc/rc.local
echo '[Service]
WorkingDirectory=/boot/firmware/PPPwn
ExecStart=/boot/firmware/PPPwn/run.sh
Restart=never
User=root
Group=root
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/pipwn.service
sudo chmod u+rwx /etc/systemd/system/pipwn.service
sudo systemctl enable pipwn
sudo systemctl start pipwn
echo -e '\033[37mInstall complete\033[0m'
