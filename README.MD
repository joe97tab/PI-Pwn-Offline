# PI-Pwn-Offline

I rewrited the script to using for OFFLINE mode.

Test on PS4 Slim FW 10.50.
- Raspberry pi 2.
- Sunvell T95m S905 2gb/8gb TV Box.
- AIS Playbox v2 S912 2gb/16gb TV Box.

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software.

---------------------------------------------------------------------------------------

Current pppwn support         (FW) : 7.00 - 11.00

[TheOfficialFloW](https://github.com/TheOfficialFloW/PPPwn)

The exploit only prints `PPPwned` on your PS4 as a proof-of-concept.

Current goldhen support       (FW) : 9.00, [9.50, 9.51, 9.60], [10.00, 10.01], 11.00

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

You need to place the goldhen.bin file onto the root of a usb drive and plug it into the console.
Once goldhen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

Current hen support           (FW) : 7.55 - 11.00

[hen-vtx](https://github.com/EchoStretch/ps4-hen-vtx/releases)

You need to place the payload.bin file onto the root of a usb drive and plug it into the console.
Once hen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

---------------------------------------------------------------------------------------


## How to install (v1) :

On PC copy all files from /PPPwn/ to /firmware/PPPwn/.

Install in terminal with this command :

```sh
sudo bash /boot/firmware/PPPwn/install.sh
```

During the install process you will be asked to set some options.

It will create config.sh and auto run script (run.sh) when boot the devices.

### Optional : speed up the boot process.

Reduced boot time and increasd overall speed by disable some services.

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

- Raspberry pi offline image (05/06/2024) :

[gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view)


- Armbian amlogic s9xx offline image (bookworm) (06/06/2024) :

May not work correctly with some S912 devices.
It also support S905x3 (not test).

[gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view)

- Armbian amlogic s9xx offline image (jammy) (28/06/2024) :

Work with s912, s905x3 may not work.

[gdrive](https://drive.google.com/file/d/1mxTshlN3Tv2iloabUE5FnuMjext5IycF/view)

---------------------------------------------------------------------------------------

## How to update 

`update v2` folder: This is current version from stooged, remove everything except offline used.

`update v1` folder: This is all-in-one version cover all firmware from 7.00-11.00.
It had a option to switch to IPv6 or IPv4, hen method (goldhen, hen-vtx and TheFlow).

`update v0` folder: Used Ipv4 only, faster speed but less stability.
FW 9.00-11.00, mainly focus on GoldHEN.

- On PC copy and replace all files from /update v2/ or /update v1/ or /update v0/ to /firmware/PPPwn/.
- Power your device, it will update and auto config from previous setup then reboot.
- You can switch between this update by repeat previous step.
- If something go wrong, check config.sh, use notepad++ to edit your desire value.

Please keep in mind that pwn your PS4 with IPv4 address is faster than IPv6.
It's better to use it if your PS4 support.

---------------------------------------------------------------------------------------

## config.sh

| Config | Description |
| --- | --- |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |
| STAGE2METHOD="goldhen" | goldhen, hen and flow |
| USEIPV6=false | false = using ipv4 (faster), true = for cursed ps4 |

`STAGE2METHOD` If no stage2 avialable it will use TheOfficialFloW.

| STAGE2METHOD | Description |
| --- | --- |
| goldhen | use goldhen, put goldhen.bin to root of usb drive |
| hen | use vtx-hen, put payload.bin to root of usb drive |
| etc | anything not in the above list will use TheOfficialFloW |

| pconfig | Description |
| --- | --- |
| XFWAP="1" | --wait-after-pin |
| XFGD="4" | --groom-delay |
| XFBS="0" | --buffer-size |
| XFNWB=true | -no-wait-padi , set to false if encounter a problem |

See [xfangfang](https://github.com/xfangfang/PPPwn_cpp) for further details.

---------------------------------------------------------------------------------------

## Tips

| PS4 FW | GoldHEN | HEN-VTX | TheOfficialFloW |
| --- | --- | --- | --- |
| 11.00 | o | o | o |
| 10.71 | x | o | o |
| 10.70 | x | o | o |
| 10.50 | x | o | o |
| 10.01 | o | o | o |
| 10.00 | o | o | o |
| 9.60 | o | o | o |
| 9.51 | ? | o | o |
| 9.50 | ? | o | o |
| 9.04 | x | o | o |
| 9.03 | x | o | o |
| 9.00 | o | o | o |
| 8.52 | x | o | o |
| 8.50 | x | o | o |
| 8.03 | x | o | o |
| 8.01 | x | o | o |
| 8.00 | x | o | o |
| 8.01 | x | o | o |
| 7.55 | x | o | o |
| 7.51 | x | x | o |
| 7.50 | x | x | o |
| 7.02 | x | x | o |
| 7.01 | x | x | o |
| 7.00 | x | x | o |

- First, use IPv6 address and TheOfficialFloW to pwn PS4.
- If it worked then change to IPv4 address.
- If everthing worked change to GoldHEN or HEN.
- no-wait-padi, can reduce pwn time but may miss captured package.
- When pwn the console don't touch anything it will increase the success rate.
 
---------------------------------------------------------------------------------------

## Credit to everyone that made it worked.
