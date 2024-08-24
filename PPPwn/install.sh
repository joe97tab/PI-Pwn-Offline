#!/bin/bash

# Offline Mode, Auto Shutdown & C++

if [ -f /boot/firmware/PPPwn/PPPwn.tar ] ; then
sudo tar -xf /boot/firmware/PPPwn/PPPwn.tar -C /boot/firmware/
else
echo -e '\r\n\033[31mInstall file not found\033[0m'
exit 1
fi

echo -e ''
echo -e '\033[37mPPPwn PS4 Jailbreak : Offline Mode, Auto Shutdown and C++\033[0m'
echo -e '\033[37mPPPwn by            : FloW\033[0m'
echo -e '\033[37mGoldhen by          : SiSTR0\033[0m'
echo -e '\033[37mHen by              : EchoStretch and BestPig\033[0m'
echo -e '\033[37mOriginal Script     : Stooged\033[0m'
echo -e '\033[37mC++ Port            : xfangfang\033[0m'
echo -e '\033[37mMod By              : joe97tab\033[0m'
echo -e ''
echo -e '\r\n\033[31mPress Ctrl+C anytime to exit this script\033[0m'
echo -e ''
echo -e '\r\n\032[31mYou can input lowercase letter choice\033[0m'

echo -e ''
echo -e '\033[37m1 ) C++ V1 support old IPv6 Only (Fastest speed)\033[0m'
echo -e '\033[37m2 ) C++ from stooged complied\033[0m'
echo -e '\033[37m3 ) C++ Lastest from xfangfang (Default)\033[0m'
echo -e '\033[37m4 ) C++ from nn9dev (1.1b1) added spray, corrupt and pin number\033[0m'
while true; do
read -p "$(printf '\r\n\033[37mPlease enter your choice for C++ method (cursed PS4 should select 2 or 3\r\n\r\n\033[37m(1|2|3|4)?: \033[0m')" cppchoice
case $cppchoice in
[1]* )
CPPM="v1"
echo -e '\r\n\033[32mC++ Version 1.0.0 for old IPv6 Only from xfangfang being used\033[0m'
break;;
[2]* ) 
CPPM="stooged"
echo -e '\r\n\033[33mC++ from stooged complied is being used\033[0m'
break;;
[3]* )
CPPM="xfangfang"
echo -e '\r\n\033[32mC++ Lastest from xfangfang is being used\033[0m'
break;;
[4]* )
CPPM="nn9dev"
echo -e '\r\n\033[32mC++ from nn9dev is being used\033[0m'
break;;
* ) echo -e '\r\n\033[31mPlease answer 1 or 2 or 3 or 4\033[0m';;
esac
done

while true; do
read -p "$(printf '\r\n\033[37mWould you like to change the firmware version being used, the default is 11.00\r\n\r\n\033[37m(Y|N)?: \033[0m')" fwset
case $fwset in
[Yy]* ) 
while true; do
read -p  "$(printf '\r\n\033[37mEnter the firmware version [ 7.00 | 7.01 | 7.02 | 7.50 | 7.51 | 7.55 | 8.00 | 8.01 | 8.03 | 8.50 | 8.52 | 9.00 | 9.03 | 9.04 | 9.50 | 9.51 | 9.60 | 10.00 | 10.01 | 10.50 | 10.70 | 10.71 | 11.00 ]: \033[0m')" FWV
case $FWV in
"" ) 
echo -e '\r\n\033[31mCannot be empty!\033[0m';;
* )  
if grep -q '^[0-9.]*$' <<<$FWV ; then 

if [[ ! "$FWV" =~ ^("7.00"|"7.01"|"7.02"|"7.50"|"7.51"|"7.55"|"8.00"|"8.01"|"8.03"|"8.50"|"8.52"|"9.00"|"9.03"|"9.04"|"9.50"|"9.51"|"9.60"|"10.00"|"10.01"|"10.50"|"10.70"|"10.71"|"11.00")$ ]]  ; then
echo -e '\r\n\033[31mThe version must be [ 7.00 | 7.01 | 7.02 | 7.50 | 7.51 | 7.55 | 8.00 | 8.01 | 8.03 | 8.50 | 8.52 | 9.00 | 9.03 | 9.04 | 9.50 | 9.51 | 9.60 | 10.00 | 10.01 | 10.50 | 10.70 | 10.71 | 11.00 ]\033[0m';
else 
break;
fi
else 
echo -e '\r\n\033[31mThe version must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\r\n\033[32mYou are using '$FWV'\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsing the default setting: 11.00\033[0m'
FWV="11.00"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

echo -e ''
echo -e '\033[37mA ) GoldHEN (FW 9.00, 9.60, 10.00, 10.01, 11.00)\033[0m'
echo -e '\033[37mB ) HEN (FW 7.00-11.00)\033[0m'
echo -e '\033[37mC ) TheOfficialFloW (No Homebrew Enable) (FW 7.00-11.00)\033[0m'
echo -e '\033[37mD ) HEN by BestPig (FW 10.50 Only)\033[0m'
nostage2=true
while $nostage2; do
while true; do
read -p "$(printf '\r\n\033[37mPlease enter your choice for jailbreak method\r\n\033[37m(A|B|C|D)?: \033[0m')" s2choice
case $s2choice in
[Aa]* ) 
if [ -f /boot/firmware/PPPwn/stage2/goldhen/stage2_${FWV//.}.bin ] ; then
S2METHOD="goldhen"
nostage2=false
echo -e '\r\n\033[32mGoldHEN is being used\033[0m'
else
echo -e '\r\n\033[31mGoldHEN not support\033[0m'
fi
break;;
[Bb]* ) 
if [ -f /boot/firmware/PPPwn/stage2/vtxhen/stage2_${FWV//.}.bin ] ; then
S2METHOD="hen"
nostage2=false
echo -e '\r\n\033[32mHEN is being used\033[0m'
else
echo -e '\r\n\033[31mHEN not support\033[0m'
fi
break;;
[Cc]* ) 
S2METHOD="flow"
nostage2=false
echo -e '\r\n\033[33mTheOfficialFloW is being used\033[0m'
break;;
[Dd]* ) 
if [ -f /boot/firmware/PPPwn/stage2/bestpig/stage2_${FWV//.}.bin ] ; then
S2METHOD="bestpig"
nostage2=false
echo -e '\r\n\033[32mHEN by BestPig is being used\033[0m'
else
echo -e '\r\n\033[31mHEN by BestPig not support\033[0m'
fi
break;;
* ) echo -e '\r\n\033[31mPlease answer A or B or C or D\033[0m';;
esac
done
done

while true; do
read -p "$(printf '\r\n\033[37mAre you using a usb to ethernet adapter for the console connection\r\n\033[37m(Y|N)?: \033[0m')" usbeth
case $usbeth in
[Yy]* ) 
USBE="true"
echo -e '\r\n\033[33mUsb to ethernet is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsb to ethernet is NOT being used\033[0m'
USBE="false"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

INUM=0
echo -e '\r\n  \033[44m\033[97m Interface list \033[0m\r\n'
readarray -t difcearr  < <(sudo ip link | cut -d " " -f-2 | cut -d ":" -f2-2)
for difce in "${difcearr[@]}"; do
if [ ! -z $difce ]; then
if [ $difce != "lo" ] && [[ $difce != *"ppp"* ]] && [[ ! $difce == *"wlan"* ]]; then
if [ -z $DEFIFCE ]; then
DEFIFCE=${difce/ /}
fi
fi
echo -e $INUM': \033[33m'${difce/ /}'\033[0m'
interfaces+=(${difce/ /})
((INUM++))
fi
done
echo -e '\r\n\033[35mDetected lan interface: \033[33m'$DEFIFCE'\033[0m'

while true; do
read -p "$(printf '\r\n\033[37mWould you like to change the lan interface, N = Using detected lan interface\r\n\033[37m(Y|N)?: \033[0m')" ifset
case $ifset in
[Yy]* ) 
while true; do
read -p  "$(printf '\r\n\033[37mEnter the interface value: \033[0m')" IFCE
case $IFCE in
"" ) 
echo -e '\r\n\033[31mCannot be empty!\033[0m';;
* )  
if grep -q '^[0-9a-zA-Z_ -]*$' <<<$IFCE ; then 
if [ ${#IFCE} -le 1 ]  || [ ${#IFCE} -ge 17 ] ; then
echo -e '\r\n\033[31mThe interface must be between 2 and 16 characters long\033[0m';
else 
break;
fi
else 
echo -e '\r\n\033[31mThe interface must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\r\n\033[33mYou are using '$IFCE'\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsing the detected setting: \033[33m'$DEFIFCE'\033[0m'
IFCE=$DEFIFCE
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

if [[ $CPPM == "v1" ]] ;then
IPV6STATE="false"
WNPSTATE="true"
SPRAYNO="1000"
CORRUPTNO="1"
PINNO="1000"
else
echo -e '\r\n\033[37mNew IPv6 slower than old IPv6, no need to using new IPv6 if pwn work\033[0m'
while true; do
read -p "$(printf '\r\n\033[37mAre you using new IPv6 for pwn, it will improve cursed PS4\r\n\033[37m(Y|N)?: \033[0m')" useipv
case $useipv in
[Yy]* ) 
IPV6STATE="true"
echo -e '\r\n\033[33mNew IPv6 is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mOld IPv6 is being used\033[0m'
IPV6STATE="false"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

echo -e '\r\n\033[37mDont wait one more PADI before starting the exploit\033[0m'
echo -e '\033[37mBy default, will wait for two PADI request, according to TheOfficialFloW this helps to improve stability but slow pwn process\033[0m'
while true; do
read -p "$(printf '\r\n\033[37mDo you want to using wait two PADI, the default is enable\r\n\033[37m(Y|N)?: \033[0m')" wnp
case $wnp in
[Yy]* ) 
echo -e '\r\n\033[33mWait two PADI\033[0m'
WNPSTATE="false"
break;;
[Nn]* ) 
echo -e '\r\n\033[32mDont wait one more PADI\033[0m'
WNPSTATE="true"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

if [[ $CPPM == "nn9dev" ]] ;then

PINNO="1000"

while true; do
read -p "$(printf '\r\n\033[37mWould you like to change the Spray Number (Hex), the default is 0x1000\r\n\033[37m(Y|N)?: \033[0m')" sprayc
case $sprayc in
[Yy]* ) 
while true; do
read -p  "$(printf '\r\n\033[37mEnter the Spray Number [400 - 1500]: \033[0m')" SPRAYNO
case $SPRAYNO in
"" ) 
echo -e '\r\n\033[31mCannot be empty!\033[0m';;
* )  
if grep -q '^[0-9]*$' <<<$SPRAYNO ; then
if [[ $((SPRAYNO)) -lt 400 ]] || [[ $((SPRAYNO)) -gt 1500 ]]; then
echo -e '\r\n\033[31mThe value must be between 400 and 1500\033[0m';
else 
break;
fi
else 
echo -e '\r\n\033[31mSpray Number must only contain a number between 400 and 1500\033[0m';
fi
esac
done
echo -e '\r\n\033[33mSpray Number (Hex) set to 0x'$SPRAYNO'\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsing the default setting: 0x1000\033[0m'
SPRAYNO="1000"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

while true; do
read -p "$(printf '\r\n\033[37mWould you like to change the Corrupt Number (Hex), the default is 0x1\r\n\033[37m(Y|N)?: \033[0m')" corruptc
case $corruptc in
[Yy]* ) 
while true; do
read -p  "$(printf '\r\n\033[37mEnter the Corrupt Number [1, 2, 4, 6, 8, 10, 14, 20, 30, 40]: \033[0m')" CORRUPTNO
case $CORRUPTNO in
"" ) 
echo -e '\r\n\033[31mCannot be empty!\033[0m';;
* )  
if grep -q '^[0-9]*$' <<<$CORRUPTNO ; then
if [[ $((CORRUPTNO)) -lt 1 ]] || [[ $((CORRUPTNO)) -gt 40 ]]; then
echo -e '\r\n\033[31mThe value must be between 1 and 40\033[0m';
else 
break;
fi
else 
echo -e '\r\n\033[31mCorrupt Number must only contain a number between 1 and 40\033[0m';
fi
esac
done
echo -e '\r\n\033[33mCorrupt Number (Hex) set to 0x'$CORRUPTNO'\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsing the default setting: 0x1\033[0m'
CORRUPTNO="1"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

else
SPRAYNO="1000"
CORRUPTNO="1"
PINNO="1000"
fi
fi

while true; do
read -p "$(printf '\r\n\033[37mWould you like to change the time delay before pppwn to start, the default is 0 (second)\r\n\033[37m(Y|N)?: \033[0m')" delayc
case $delayc in
[Yy]* ) 
while true; do
read -p  "$(printf '\r\n\033[37mEnter the delay start value [0 - 20]: \033[0m')" DELAYS
case $DELAYS in
"" ) 
echo -e '\r\n\033[31mCannot be empty!\033[0m';;
* )  
if grep -q '^[0-9]*$' <<<$DELAYS ; then
if [[ $((DELAYS)) -lt 0 ]] || [[ $((DELAYS)) -gt 20 ]]; then
echo -e '\r\n\033[31mThe value must be between 0 and 20\033[0m';
else 
break;
fi
else 
echo -e '\r\n\033[31mThe delay time must only contain a number between 0 and 20\033[0m';
fi
esac
done
echo -e '\r\n\033[33mDelay start set to '$DELAYS' (seconds)\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[32mUsing the default setting: 0 (second)\033[0m'
DELAYS="0"
break;;
* ) echo -e '\r\n\033[31mPlease answer Y or N\033[0m';;
esac
done

echo -e ''

# create general config
echo '#!/bin/bash
CPPMETHOD="'$CPPM'"
INTERFACE="'$IFCE'"
FIRMWAREVERSION="'$FWV'"
USBETHERNET='$USBE'
STAGE2METHOD="'$S2METHOD'"
NEWIPV6='$IPV6STATE'
DELAYSTART="'$DELAYS'"' | sudo tee /boot/firmware/PPPwn/config.sh

# create pppwn c++ config
echo '#!/bin/bash
XFWAP="1"
XFGD="4"
XFBS="0"
XFNWB='$WNPSTATE'
SPRAY_NUM="'$SPRAYNO'"
CORRUPT_NUM="'$CORRUPTNO'"
PIN_NUM="'$PINNO'"' | sudo tee /boot/firmware/PPPwn/pconfig.sh

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
sudo rm /boot/firmware/PPPwn/PPPwn.tar
sudo chmod u+rwx /etc/systemd/system/pipwn.service
sudo systemctl enable pipwn
sudo systemctl start pipwn
echo -e '\033[37mInstall complete\033[0m'
echo -e ''
echo -e '\r\n\032[31mRun : sudo poweroff : to shutdown the device\033[0m'
echo -e '\r\n\032[31mor\033[0m' 
echo -e '\r\n\032[31mPress Ctrl+C to stop pppwn\033[0m'

