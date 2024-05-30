#!/bin/bash

if [ -z $1 ] ;then
sudo apt install pppoe dnsmasq iptables nginx php-fpm nmap at -y
echo 'bogus-priv
expand-hosts
domain-needed
server=8.8.8.8
listen-address=127.0.0.1
port=5353
conf-file=/etc/dnsmasq.more.conf' | sudo tee /etc/dnsmasq.conf
echo 'auth
lcp-echo-failure 3
lcp-echo-interval 60
mtu 1482
mru 1482
require-pap
ms-dns 192.168.2.1
netmask 255.255.255.0
defaultroute
noipdefault
usepeerdns' | sudo tee /etc/ppp/pppoe-server-options
echo '[Service]
WorkingDirectory=/boot/firmware/PPPwn
ExecStart=/boot/firmware/PPPwn/pppoe.sh
Restart=never
User=root
Group=root
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/pppoe.service
echo '[Service]
WorkingDirectory=/boot/firmware/PPPwn
ExecStart=/boot/firmware/PPPwn/dtlink.sh
Restart=never
User=root
Group=root
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/dtlink.service
PHPVER=$(sudo php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d".")
echo 'server {
	listen 80 default_server;
	listen [::]:80 default_server;
	root /boot/firmware/PPPwn;
	index index.html index.htm index.php;
	server_name _;
	location / {
		try_files $uri $uri/ =404;
	}
	error_page 404 = @mainindex;
	location @mainindex {
	return 302 /;
	}
	location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php'$PHPVER'-fpm.sock;
	}
}' | sudo tee /etc/nginx/sites-enabled/default
sudo sed -i "s^www-data	ALL=(ALL) NOPASSWD: ALL^^g" /etc/sudoers
echo 'www-data	ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers
sudo /etc/init.d/nginx restart
if [ ! -f /etc/udev/rules.d/99-pwnmnt.rules ]; then
sudo mkdir /media/pwndrives
echo 'MountFlags=shared' | sudo tee -a /usr/lib/systemd/system/systemd-udevd.service
echo 'ACTION=="add", KERNEL=="sd*", SUBSYSTEMS=="usb|scsi", DRIVERS=="sd", SYMLINK+="usbdrive", RUN+="/boot/firmware/PPPwn/pwnmount.sh $kernel"
ACTION=="remove", SUBSYSTEM=="block", RUN+="/boot/firmware/PPPwn/pwnumount.sh $kernel"' | sudo tee /etc/udev/rules.d/99-pwnmnt.rules
sudo udevadm control --reload
fi
if [ -f /media/pwndrives ]; then
sudo mkdir /media/pwndrives
fi
PPSTAT=$(sudo systemctl list-unit-files --state=enabled --type=service|grep pppoe) 
if [[ ! $PPSTAT == "" ]] ; then
sudo systemctl disable pppoe
fi
if [ ! -f /boot/firmware/PPPwn/ports.txt ]; then
echo '2121,3232,9090,8080,12800,1337' | sudo tee /boot/firmware/PPPwn/ports.txt
fi
sudo sed -i 's^"exit 0"^"exit"^g' /etc/rc.local
sudo sed -i 's^sudo bash /boot/firmware/PPPwn/devboot.sh \&^^g' /etc/rc.local
sudo sed -i 's^exit 0^sudo bash /boot/firmware/PPPwn/devboot.sh \&\n\nexit 0^g' /etc/rc.local
if [[ $(dpkg-query -W --showformat='${Status}\n' python3-scapy|grep "install ok installed")  == "" ]] ;then
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to enable the option to use the python(slower) PPPwn\033[36m(Y|N)?: \033[0m')" pypwnopt
case $pypwnopt in
[Yy]* ) 
sudo apt install python3 python3-scapy -y
break;;
[Nn]* ) 
UPYPWN="false"
echo -e '\033[35mThe python version of PPPwn will not be available\033[0m'
break;;
* ) 
echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
if [[ $(dpkg-query -W --showformat='${Status}\n' vsftpd|grep "install ok installed")  == "" ]] ;then
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to install a FTP server? (Y|N):\033[0m ')" ftpq
case $ftpq in
[Yy]* ) 
sudo apt-get install vsftpd -y
echo "listen=YES
local_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=077
allow_writeable_chroot=YES
chroot_local_user=YES
user_sub_token=$USER
local_root=/boot/firmware/PPPwn" | sudo tee /etc/vsftpd.conf
sudo sed -i 's^root^^g' /etc/ftpusers
echo -e '\n\n\033[33mTo use FTP you must set the \033[36mroot\033[33m account password so you can login to the ftp server with full write permissions\033[0m\n'
while true; do
read -p "$(printf '\r\n\033[36mDo you want to set the \033[36mroot\033[36m account password\r\n\r\n\033[36m(Y|N)?: \033[0m')" rapw
case $rapw in
[Yy]* ) 
sudo passwd root
echo -e '\r\n\033[33mYou can log into the ftp server with\r\nUsername: \033[36mroot\033[33m\r\nand the password you just set\033[0m'
break;;
[Nn]* ) 
echo -e '\r\n\033[33mYou can log into the ftp server with\r\nUsername: root\r\nand the password you just set\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
echo -e '\033[32mFTP Installed\033[0m'
break;;
[Nn]* ) echo -e '\033[35mSkipping FTP install\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
if [[ $(dpkg-query -W --showformat='${Status}\n' samba|grep "install ok installed")  == "" ]] ;then
while true; do
read -p "$(printf '\r\n\r\n\033[36mnDo you want to setup a SAMBA share? (Y|N):\033[0m ')" smbq
case $smbq in
[Yy]* ) 
sudo apt-get install samba samba-common-bin -y
echo '[global]
;   interfaces = 127.0.0.0/8 eth0
;   bind interfaces only = yes
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   panic action = /usr/share/samba/panic-action %d
   server role = standalone server
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user
;   logon path = \\%N\profiles\%U
;   logon drive = H:
;   logon script = logon.cmd
; add user script = /usr/sbin/useradd --create-home %u
; add machine script  = /usr/sbin/useradd -g machines -c "%u machine account" -d /var/lib/samba -s /bin/false %u
; add group script = /usr/sbin/addgroup --force-badname %g
;   include = /home/samba/etc/smb.conf.%m
;   idmap config * :              backend = tdb
;   idmap config * :              range   = 3000-7999
;   idmap config YOURDOMAINHERE : backend = tdb
;   idmap config YOURDOMAINHERE : range   = 100000-999999
;   template shell = /bin/bash
   usershare allow guests = yes
[homes]
   comment = Home Directories
   browseable = no
   read only = yes
   create mask = 0700
   directory mask = 0700
   valid users = %S
;[netlogon]
;   comment = Network Logon Service
;   path = /home/samba/netlogon
;   guest ok = yes
;   read only = yes
;[profiles]
;   comment = Users profiles
;   path = /home/samba/profiles
;   guest ok = no
;   browseable = no
;   create mask = 0600
;   directory mask = 0700
[printers]
   comment = All Printers
   browseable = no
   path = /var/tmp
   printable = yes
   guest ok = no
   read only = yes
   create mask = 0700
[print$]
   comment = Printer Drivers
   path = /var/lib/samba/printers
   browseable = yes
   read only = yes
   guest ok = no
;   write list = root, @lpadmin
[pppwn]
path = /boot/firmware/PPPwn/
writeable=Yes
create mask=0777
read only = no
directory mask=0777
force create mask = 0777
force directory mask = 0777
force user = root
force group = root
public=yes' | sudo tee /etc/samba/smb.conf
sudo systemctl unmask smbd
sudo systemctl enable smbd
echo -e '\033[32mSamba installed\033[0m'
break;;
[Nn]* ) echo -e '\033[35mSkipping SAMBA install\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
if [ -f /boot/firmware/PPPwn/config.sh ]; then
while true; do
read -p "$(printf '\r\n\r\n\033[36mConfig found, Do you want to change the stored settings\033[36m(Y|N)?: \033[0m')" conf
case $conf in
[Yy]* ) 
break;;
[Nn]* ) 
sudo systemctl start pipwn
echo -e '\033[36mUpdate complete\033[0m'
exit 1
break;;
* ) 
echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
if [[ $(dpkg-query -W --showformat='${Status}\n' python3-scapy|grep "install ok installed")  == "" ]] ;then
UPYPWN="false"
else
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to use the old python version of pppwn, It is much slower\r\n\r\n\033[36m(Y|N)?: \033[0m')" pypwn
case $pypwn in
[Yy]* ) 
UPYPWN="true"
echo -e '\033[32mThe Python version of PPPwn is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mThe C++ version of PPPwn is being used\033[0m'
UPYPWN="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to change the PPPoE username and password?\r\nif you select no then these defaults will be used\r\n\r\nUsername: \033[33mppp\r\n\033[36mPassword: \033[33mppp\r\n\r\n\033[36m(Y|N)?: \033[0m')" wapset
case $wapset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[33mEnter Username: \033[0m')" PPPU
case $PPPU in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[0-9a-zA-Z_ -]*$' <<<$PPPU ; then 
if [ ${#PPPU} -le 1 ]  || [ ${#PPPU} -ge 33 ] ; then
echo -e '\033[31mUsername must be between 2 and 32 characters long\033[0m';
else 
break;
fi
else 
echo -e '\033[31mUsername must only contain alphanumeric characters\033[0m';
fi
esac
done
while true; do
read -p "$(printf '\033[33mEnter password: \033[0m')" PPPW
case $PPPW in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if [ ${#PPPW} -le 1 ]  || [ ${#PPPW} -ge 33 ] ; then
echo -e '\033[31mPassword must be between 2 and 32 characters long\033[0m';
else 
break;
fi
esac
done
echo -e '\033[36mUsing custom settings\r\n\r\nUsername: \033[33m'$PPPU'\r\n\033[36mPassword: \033[33m'$PPPW'\r\n\r\n\033[0m'
break;;
[Nn]* ) 
echo -e '\033[36mUsing default settings\r\n\r\nUsername: \033[33mppp\r\n\033[36mPassword: \033[33mppp\r\n\r\n\033[0m'
 PPPU="ppp"
 PPPW="ppp"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
echo '"'$PPPU'"  *  "'$PPPW'"  192.168.2.2' | sudo tee /etc/ppp/pap-secrets
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to detect console shutdown and restart PPPwn\r\n\r\n\033[36m(Y|N)?: \033[0m')" dlnk
case $dlnk in
[Yy]* ) 
DTLNK="true"
echo -e '\033[32mDetect shutdown enabled\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mDetect shutdown disabled\033[0m'
DTLNK="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want the console to connect to the internet after PPPwn? (Y|N):\033[0m ')" pppq
case $pppq in
[Yy]* ) 
INET="true"
SHTDN="false"
echo -e '\033[32mConsole internet access enabled\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mConsole internet access disabled\033[0m'
INET="false"
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want the pi to shutdown after pwn success\r\n\r\n\033[36m(Y|N)?: \033[0m')" pisht
case $pisht in
[Yy]* ) 
SHTDN="true"
echo -e '\033[32mThe pi will shutdown\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mThe pi will not shutdown\033[0m'
SHTDN="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mAre you using a usb to ethernet adapter for the console connection\r\n\r\n\033[36m(Y|N)?: \033[0m')" usbeth
case $usbeth in
[Yy]* ) 
USBE="true"
echo -e '\033[32mUsb to ethernet is being used\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mUsb to ethernet is NOT being used\033[0m'
USBE="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want to try and detect if goldhen is running and skip running pppwn if found, useful for rest mode\r\n\r\n\033[36m(Y|N)?: \033[0m')" restmd
case $restmd in
[Yy]* ) 
RESTM="true"
echo -e '\033[32mGoldhen detection enabled\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mGoldhen detection disabled\033[0m'
RESTM="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want pppwn to run in verbose mode\r\n\r\n\033[36m(Y|N)?: \033[0m')" ppdbg
case $ppdbg in
[Yy]* ) 
PDBG="true"
echo -e '\033[32mPPPwn will run in verbose mode\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mPPPwn will NOT run in verbose mode\033[0m'
PDBG="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mWould you like to change the timeout for pppwn to restart if it hangs, the default is 5 (minutes)\r\n\r\n\033[36m(Y|N)?: \033[0m')" tmout
case $tmout in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[33mEnter the timeout value [1 | 2 | 3 | 4 | 5]: \033[0m')" TOUT
case $TOUT in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[1-5]*$' <<<$TOUT ; then 
if [[ ! "$TOUT" =~ ^("1"|"2"|"3"|"4"|"5")$ ]]  ; then
echo -e '\033[31mThe value must be between 1 and 5\033[0m';
else 
break;
fi
else 
echo -e '\033[31mThe timeout must only contain a number between 1 and 5\033[0m';
fi
esac
done
echo -e '\033[32mTimeout set to '$TOUT' (minutes)\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mUsing the default setting: 5 (minutes)\033[0m'
TOUT="5"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
while true; do
read -p "$(printf '\r\n\r\n\033[36mWould you like to change the firmware version being used, the default is 11.00\r\n\r\n\033[36m(Y|N)?: \033[0m')" fwset
case $fwset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[33mEnter the firmware version [ 11.00 | 10.00 | 10.01 | 9.00 ]: \033[0m')" FWV
case $FWV in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[0-9.]*$' <<<$FWV ; then 

if [[ ! "$FWV" =~ ^("11.00"|"10.00"|"10.01"|"9.00")$ ]]  ; then
echo -e '\033[31mThe version must be [ 11.00 | 10.00 | 10.01 | 9.00 ]\033[0m';
else 
break;
fi
else 
echo -e '\033[31mThe version must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\033[32mYou are using '$FWV'\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mUsing the default setting: 11.00\033[0m'
FWV="11.00"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
ip link
while true; do
read -p "$(printf '\r\n\r\n\033[36mWould you like to change the pi lan interface, the default is eth0\r\n\r\n\033[36m(Y|N)?: \033[0m')" ifset
case $ifset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[33mEnter the interface value: \033[0m')" IFCE
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
echo -e '\033[32mYou are using '$IFCE'\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mUsing the default setting: eth0\033[0m'
IFCE="eth0"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
PITYP=$(tr -d '\0' </proc/device-tree/model) 
if [[ $PITYP == *"Raspberry Pi 4"* ]] || [[ $PITYP == *"Raspberry Pi 5"* ]] ;then
while true; do
read -p "$(printf '\r\n\r\n\033[36mDo you want the pi to act as a flash drive to the console\r\n\r\n\033[36m(Y|N)?: \033[0m')" vusb
case $vusb in
[Yy]* ) 
echo -e '\033[32mThe pi will mount as a drive\n\033[33mYou must plug the pi into the console usb port using the \033[35musb-c\033[33m of the pi and the usb drive in the pi must contain a folder named \033[35mpayloads\033[0m'
sudo sed -i "s^dtoverlay=dwc2^^g" /boot/firmware/config.txt
echo 'dtoverlay=dwc2' | sudo tee -a /boot/firmware/config.txt
VUSB="true"
break;;
[Nn]* ) 
echo -e '\033[35mThe pi will not mount as a drive\033[0m'
sudo sed -i "s^dtoverlay=dwc2^^g" /boot/firmware/config.txt
VUSB="false"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
else
VUSB="false"
fi
while true; do
read -p "$(printf '\r\n\r\n\033[36mWould you like to change the hostname, the default is pppwn\r\n\r\n\033[36m(Y|N)?: \033[0m')" hstset
case $hstset in
[Yy]* ) 
while true; do
read -p  "$(printf '\033[33mEnter the hostname: \033[0m')" HSTN
case $HSTN in
"" ) 
 echo -e '\033[31mCannot be empty!\033[0m';;
 * )  
if grep -q '^[0-9a-zA-Z_ -]*$' <<<$HSTN ; then 
if [ ${#HSTN} -le 3 ]  || [ ${#HSTN} -ge 21 ] ; then
echo -e '\033[31mThe interface must be between 4 and 21 characters long\033[0m';
else 
break;
fi
else 
echo -e '\033[31mThe hostname must only contain alphanumeric characters\033[0m';
fi
esac
done
echo -e '\033[32mYou are using '$HSTN', to access the webserver use http://'$HSTN'.local\033[0m'
break;;
[Nn]* ) 
echo -e '\033[35mUsing the default setting: pppwn\033[0m'
HSTN="pppwn"
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
echo 'address=/manuals.playstation.net/192.168.2.1
address=/playstation.com/127.0.0.1
address=/playstation.net/127.0.0.1
address=/playstation.org/127.0.0.1
address=/akadns.net/127.0.0.1
address=/akamai.net/127.0.0.1
address=/akamaiedge.net/127.0.0.1
address=/edgekey.net/127.0.0.1
address=/edgesuite.net/127.0.0.1
address=/llnwd.net/127.0.0.1
address=/scea.com/127.0.0.1
address=/sie-rd.com/127.0.0.1
address=/llnwi.net/127.0.0.1
address=/sonyentertainmentnetwork.com/127.0.0.1
address=/ribob01.net/127.0.0.1
address=/cddbp.net/127.0.0.1
address=/nintendo.net/127.0.0.1
address=/ea.com/127.0.0.1
address=/'$HSTN'.local/192.168.2.1' | sudo tee /etc/dnsmasq.more.conf
sudo systemctl restart dnsmasq
echo '#!/bin/bash
INTERFACE="'$IFCE'" 
FIRMWAREVERSION="'$FWV'" 
SHUTDOWN='$SHTDN'
USBETHERNET='$USBE'
PPPOECONN='$INET'
VMUSB='$VUSB'
DTLINK='$DTLNK'
RESTMODE='$RESTM'
PPDBG='$PDBG'
TIMEOUT="'$TOUT'm"
PYPWN='$UPYPWN'' | sudo tee /boot/firmware/PPPwn/config.sh
sudo rm -f /usr/lib/systemd/system/network-online.target
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
sudo chmod u+rwx /etc/systemd/system/pppoe.service
sudo chmod u+rwx /etc/systemd/system/dtlink.service
sudo systemctl enable pipwn
CHSTN=$(hostname | cut -f1 -d' ')
sudo sed -i "s^$CHSTN^$HSTN^g" /etc/hosts
sudo sed -i "s^$CHSTN^$HSTN^g" /etc/hostname
echo -e '\033[36mInstall complete,\033[33m Rebooting\033[0m'
sudo reboot
else
echo "Update complete, Rebooting."  | sudo tee /dev/tty1 | sudo tee /dev/pts/* | sudo tee -a /boot/firmware/PPPwn/upd.log
coproc read -t 6 && wait "$!" || true
sudo reboot
fi