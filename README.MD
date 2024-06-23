# PI-Pwn-Offline

I rewrited stooged script to using for OFFLINE mode.

Used IPv6, c++ binary and bin from stooged.

Test on PS4 Slim FW 10.50, Raspberry pi 2 and Sunvell T95m S905 TV Box.

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software.

---------------------------------------------------------------------------------------

Current goldhen support       (FW) : 9.00, [9.50, 9.51, 9.60], [10.00, 10.01], 11.00

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

You need to place the goldhen.bin file onto the root of a usb drive and plug it into the console.
Once goldhen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

Current hen-vtx support       (FW) : All hen method base on stooged worked.

[hen-vtx](https://github.com/EchoStretch/ps4-hen-vtx/releases)

Current pppwn support         (FW) : 7.00 - 11.00

When pwn the console don't touch anything it will increase the success rate.

---------------------------------------------------------------------------------------


## How to install :

Copy all files from /PPPwn/ to /firmware/PPPwn/.

Install with this command :

```sh
sudo bash /boot/firmware/PPPwn/install.sh
```

During the install process you will be asked to set some options.

It will create config.sh and auto run script (run.sh) when boot the devices.

### Optional : speed up the boot process.

Copy all files from /tuning/ to /firmware/tuning/.

Raspbian :

```sh
sudo bash /boot/firmware/tuning/speedup_raspbian.sh
```

Armbian :

```sh
sudo bash /boot/firmware/tuning/speedup_armbian.sh
```

Shut down and connect to ps4 and test your pppwn.

On your PS4:

- Go to `Settings` and then `Network`
- Select `Set Up Internet connection` and choose `Use a LAN Cable`
- Choose `Custom` setup and choose `PPPoE` for `IP Address Settings`
- Enter anything for `PPPoE User ID` and `PPPoE Password`
- Choose `Automatic` for `DNS Settings` and `MTU Settings`
- Choose `Do Not Use` for `Proxy Server`

Normally the pwn process will success on first or second attempt.

---------------------------------------------------------------------------------------

## Ready to use installed-image.

Very easy to setup. Burn image, edit config.sh, test your pwn.

- Raspberry pi offline image :

[gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view)


- Armbian amlogic s9xx offline image :

[gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view)


---------------------------------------------------------------------------------------

## How to update 

`update v2` folder: This is current version from stooged, remove everything except offline used.

`update v1` folder: This is old version mainly focus on IPv4 and seperated stage2.bin.
It had a option to switch to IPv6, hen method (goldhen, hen-vtx, Bestpig, noBD and TheFlow).

`update v0` folder: Used Ipv4 only, faster speed but less stability.
FW 9.00-11.00, mainly focus on GoldHEN.

- On PC copy and replace all files from /update v2/ or /update v1/ or /update v0/ to /firmware/PPPwn/.
- Power your device, it will update and auto config from previous setup then reboot.
- You can switch between this update by repeat previous step.
- If something go wrong, check config.sh, use notepad++ to edit your desire value.

Please keep in mind that pwn your PS4 with IPv4 address is faster than IPv6.
It's better to use it if your PS4 support.

---------------------------------------------------------------------------------------
## config.sh, pconfig.sh for current version

| Config | Description |
| --- | --- |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |
| USEIPV6=false | false = using ipv4 (faster), true = for cursed ps4 |

| pconfig | Description |
| --- | --- |
| XFWAP="1" | --wait-after-pin |
| XFGD="4" | --groom-delay |
| XFBS="0" | --buffer-size |
| XFNWB=true | -no-wait-padi , set to false if encounter a problem |

See [xfangfang](https://github.com/xfangfang/PPPwn_cpp) for further details.

---------------------------------------------------------------------------------------

## Credit to everyone that made it worked.
