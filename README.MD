# PI-Pwn-Offline

I rewrited the script to using device to pwn PS4 for offline mode.

Test on PS4 Slim FW 10.50.
- Raspberry pi 2.
- Sunvell T95m S905 2gb/8gb TV Box.
- AIS Playbox v2 S912 2gb/16gb TV Box (not root).

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software, no root required.

---------------------------------------------------------------------------------------

Current PPPwn support          (FW) : 7.00 - 11.00

[TheOfficialFloW](https://github.com/TheOfficialFloW/PPPwn)

The exploit only prints `PPPwned` on your PS4 as a proof-of-concept.

Current GoldHEN support        (FW) : 9.00, 9.60, 10.00, 10.01, 11.00

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

You need to place the goldhen.bin file onto the root of a usb drive and plug it into the console.
Once goldhen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

Current HEN support            (FW) : 7.00 - 11.00

[hen-vtx](https://github.com/EchoStretch/ps4-hen-vtx/releases)

You need to place the payload.bin file onto the root of a usb drive and plug it into the console.
Once hen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

Current HEN by BestPig support (FW) : 10.50

[BestPig](https://github.com/BestPig/ps4-hen-vtx/releases)

No need to place any file onto the root of a usb drive.

---------------------------------------------------------------------------------------


## How to install :

On PC, Insert SDCARD, create /firmware/PPPwn/ folder then copy all files from /PPPwn/ to SDCARD/firmware/PPPwn/.

When boot the device, install in terminal with this command :

```sh
sudo bash /boot/firmware/PPPwn/install.sh
```

During the install process you will be asked to set some options.

It will create config.sh, pconfig.sh and auto run script (run.sh) when boot the devices.

### Optional : speed up the boot process.

Reduced boot time and increased overall speed by disable some services.

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

### Optional 2 : Other run script.

I added other script (run2.sh) , if you have a problem to run PPPwn in your device.

Simple rename run2.sh in SDCARD/firmware/PPPwn/ to run.sh.

---------------------------------------------------------------------------------------

## Ready to use installed-image.

Very easy to setup. Write image, edit config.sh then test your pwn.

- Raspberry pi offline image (05/06/2024) :

[gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view)


- Armbian amlogic s9xx offline image (bookworm) (06/06/2024) :

May not work correctly with some S912 devices.
It also support S905x3 (not test).

[gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view)

- Armbian amlogic s9xx offline image (jammy) (28/06/2024) :

Work with s912, s905x3 may not work.

[gdrive](https://drive.google.com/file/d/1mxTshlN3Tv2iloabUE5FnuMjext5IycF/view)

If you see "Ready for console connection" mean your device ready for pppwn, please update the lastest script in the section `How to update`.

---------------------------------------------------------------------------------------

## How to update

- On PC, Insert SDCARD, copy and replace files /update/run.sh and /PPPwn/PPPwn.tar to SDCARD/firmware/PPPwn/.
- Power your device, it will auto update and reconfig from previous setup then reboot.
- If something go wrong, check config.sh and pconfig.sh, use notepad++ to edit your desire value.

Please keep in mind that pwn your PS4 with IPv4 address is faster than IPv6.
It's better to use it if your PS4 support.

## config.sh, pconfig.sh

Config file location : SDCARD/firmware/PPPwn/

| config.sh | Description |
| --- | --- |
| CPPMETHOD="1" | 1 = v1 IPv4 Only (fastest speed), 2 = stooged binary, etc = lastest xfangfang binary |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |
| STAGE2METHOD="goldhen" | goldhen, hen, bestpig (10.50 Only) and flow |
| USEIPV6=false | false = using ipv4 (faster), true = for cursed ps4 |
| DELAYSTART="0" | delay time before pppwn start, set value between 0-15 seconds |

`CPPMETHOD` If incorrect cpp setup it will use lastest xfangfang binary.
Stooged binary (CPPMETHOD="2") had intregrated stage1, stage2 and hen-vtx into the binary, for hen-vtx, no need to place payload.bin onto the root of a usb drive.

`STAGE2METHOD` If no stage2 avialable it will use TheOfficialFloW.

| STAGE2METHOD | Description |
| --- | --- |
| goldhen | use goldhen, put goldhen.bin to root of usb drive |
| hen | use vtx-hen, put payload.bin to root of usb drive |
| bestpig | use hen by BestPig, FW 10.50 Only |
| etc | anything not in the above list will use TheOfficialFloW |

| pconfig.sh | Description |
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
| 11.00 | `o` | o | o |
| 10.71 | x | o | o |
| 10.70 | x | o | o |
| 10.50 | x | o | o |
| 10.01 | `o` | o | o |
| 10.00 | `o` | o | o |
| 9.60 | `o` | o | o |
| 9.51 | x | o | o |
| 9.50 | x | o | o |
| 9.04 | x | o | o |
| 9.03 | x | o | o |
| 9.00 | `o` | o | o |
| 8.52 | x | o | o |
| 8.50 | x | o | o |
| 8.03 | x | o | o |
| 8.01 | x | o | o |
| 8.00 | x | o | o |
| 8.01 | x | o | o |
| 7.55 | x | o | o |
| 7.51 | x | o | o |
| 7.50 | x | o | o |
| 7.02 | x | o | o |
| 7.01 | x | o | o |
| 7.00 | x | o | o |

- First, use IPv6 address (CPPMETHOD="2" or CPPMETHOD="3"), USEIPV6=true and TheOfficialFloW (STAGE2METHOD="flow") to pwn PS4.
- If it worked then change to IPv4 address (USEIPV6=false).
- If your ps4 not cursed then change `CPPMETHOD` to "1".
- Then set `STAGE2METHOD` to GoldHEN or HEN depend on your firmware version.
- no-wait-padi, can reduce pwn time but may miss captured package.
- When pwn the console don't touch anything it will increase the success rate.
- `Cannot connect to network: (NW-31274-7).` It means the program try to injection, sometime the exploit fails or the PS4 crashes.
- `LAN cable not connected.` It means the program will try next attempt, if pwn success it turns off Ethernet interface and shutdown the device.

---------------------------------------------------------------------------------------

## Credit to everyone that made it worked.
