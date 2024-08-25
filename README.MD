# PI-Pwn-Offline

I rewrited the script to using device to pwn PS4 for offline mode.

Test on PS4 Slim FW 10.50.
- Raspberry pi 2.
- Sunvell T95m S905 2gb/8gb TV Box.
- AIS Playbox v2 S912 2gb/16gb TV Box (not root).

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software, no root required.

The image should no graphic interfaces, CLi, current, default, minimal.

---------------------------------------------------------------------------------------

[TheOfficialFloW](https://github.com/TheOfficialFloW/PPPwn)

Current PPPwn support          (FW) : 7.00 - 11.00

The exploit only prints `PPPwned` on your PS4 as a proof-of-concept.

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

Current GoldHEN support        (FW) : 9.00, 9.60, 10.00, 10.01, 11.00

You need to place the goldhen.bin file onto the root of a usb drive and plug it into the console.
Once goldhen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

[hen-vtx](https://github.com/EchoStretch/ps4-hen-vtx/releases)

Current HEN support            (FW) : 7.00 - 11.00

You need to place the payload.bin file onto the root of a usb drive and plug it into the console.
Once hen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

[BestPig](https://github.com/BestPig/ps4-hen-vtx/releases)

Current HEN by BestPig support (FW) : 10.50

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

Please run this script before run install.sh, copy `speedup_raspbian.sh` or `speedup_armbian.sh` from /tuning/ to /firmware/PPPwn/.

Raspbian :

```sh
sudo bash /boot/firmware/PPPwn/speedup_raspbian.sh
```

Armbian :

```sh
sudo bash /boot/firmware/PPPwn/speedup_armbian.sh
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

I added other script (run2.sh) , if you have a problem to run PPPwn with your device.

Simple rename run2.sh in SDCARD/firmware/PPPwn/ to run.sh.

---------------------------------------------------------------------------------------

## Ready to use installed-image.

Very easy to setup. Write image, edit config.sh, pconfig.sh then test your pwn.

Lastest update : 16/08/2024

| Offline image | distro | SDCARD | Download |
| --- | --- | --- | --- |
| Raspberry pi | buster, up to pi4| 4GB or above | [gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view) |
| Armbian amlogic | bookworm, s912 may not work | 4GB or above | [gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view) |
| Armbian amlogic | jammy, s905x3 may not work | 2GB or above | [gdrive](https://drive.google.com/file/d/1mxTshlN3Tv2iloabUE5FnuMjext5IycF/view) |

If you see "Ready for console connection" it means your device ready for pppwn, please update the lastest script in the section `How to update`.

---------------------------------------------------------------------------------------

## How to update

- On PC, Insert SDCARD, copy and replace files `/update/run.sh` and `/PPPwn/PPPwn.tar` to SDCARD/firmware/PPPwn/.
- Power your device, it will auto update and reconfig from previous setup then continue pwn PS4 (no need to reboot).
- If GoldHEN avialable it will auto switch from HEN to GoldHEN.
- If something go wrong, check config.sh and pconfig.sh, use notepad++ to edit your desire value.
- Configuration file templates locate in /tuning/.

Please keep in mind that pwn your PS4 with old IPv6 address is faster than new IPv6.

It's better to use it if your PS4 support.

## config.sh, pconfig.sh

Config file location : SDCARD/firmware/PPPwn/

| config.sh | Description |
| --- | --- |
| CPPMETHOD="1" | 1 = v1 Old IPv6 Only (fastest speed), 2 = stooged binary, 3 = lastest xfangfang binary, 4 = nn9dev binary |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |
| STAGE2METHOD="goldhen" | goldhen, hen, bestpig (10.50 Only) and flow |
| NEWIPV6=false | false = using old IPv6 (faster), true = for cursed ps4 |
| DELAYSTART="0" | delay time before pppwn start, set value between 0-20 seconds |

`DELAYSTART` uses for adjust your device to ready for pppwn after ps4 finish boot to home screen. 

`CPPMETHOD` If incorrect cpp setup it will use lastest xfangfang binary.

Stooged binary (CPPMETHOD="2") had intregrated stage1, stage2 and hen-vtx into the binary, for hen-vtx, no need to place payload.bin onto the root of a usb drive.

Nn9dev binary (CPPMETHOD="4") added new feature it added spray number, corrupt number and pin number, it hopes to improve stability.

| CPPMETHOD | - | Old IPv6 | New IPv6 | wait-after-pin | groom-delay | buffer-size | no-wait-padi | spray no. | corrupt no. | pin no. |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | v1 | o | x | x | x | x | x | x | x | x |
| 2 | stooged | o | o | o | o | o | o | x | x | x |
| 3 | xfangfang | o | o | o | o | o | o | x | x | x |
| 4 | nn9dev | o | o | o | o | o | o | o | o | o |

`STAGE2METHOD` If no stage2 avialable it will use TheOfficialFloW.

| STAGE2METHOD | Description |
| --- | --- |
| goldhen | use goldhen, put goldhen.bin to root of usb drive |
| hen | use vtx-hen, put payload.bin to root of usb drive |
| bestpig | use hen by BestPig, FW 10.50 Only |
| etc | anything not in the above list will use TheOfficialFloW |

If incorrect pconfig setup it will use default value.

| pconfig.sh | Description |
| --- | --- |
| XFWAP="1" | wait-after-pin, set value between 1-20 seconds|
| XFGD="4" | groom-delay, set value between 1-4097 ms |
| XFBS="0" | buffer-size, set value between 0-20480 |
| XFNWB=true | no-wait-padi , set to false if encounter a problem |
| For | CPPMETHOD="4" Only |
| SPRAY_NUM="0x1000" | set value between 0x400-0x1500 (0x1000, 0x1050, 0x1100, 0x1150,... ) |
| CORRUPT_NUM="0x1" | set value 0x1, 0x2, 0x4, 0x6, 0x8, 0x10, 0x14, 0x20, 0x30, 0x40 |
| PIN_NUM="0x1000" | it's fine to leave this at default |

See [xfangfang](https://github.com/xfangfang/PPPwn_cpp), [nn9dev](https://github.com/nn9dev/PiPiPenetrate) for further details.

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
| 7.55 | x | o | o |
| 7.51 | x | o | o |
| 7.50 | x | o | o |
| 7.02 | x | o | o |
| 7.01 | x | o | o |
| 7.00 | x | o | o |

- First, use new IPv6 address (CPPMETHOD="2" or CPPMETHOD="3"), NEWIPV6=true and TheOfficialFloW (STAGE2METHOD="flow") to pwn PS4.
- If it worked then change to old IPv6 address (NEWIPV6=false).
- If it worked your ps4 may not cursed then change `CPPMETHOD` to "1".
- Then set `STAGE2METHOD` to GoldHEN or HEN depend on your firmware version.
- HEN is enough if you only run homebrew or fpkg game, no need to using GoldHEN, firmware lower the better.
- HEN now supports [Payload Guest](https://github.com/Al-Azif/ps4-payload-guest/releases), put [payloads](https://github.com/TheWizWikii/All-PS4-Payloads) that match your FW in USB/payloads/ or PS4HDD/data/payloads/.
- no-wait-padi, can reduces pwn time but may miss captured package.
- When pwn the console don't touch anything it will increase the success rate.
- `Cannot connect to network: (NW-31274-7).` It means the program try to injection, sometime the exploit fails or the PS4 crashes.
- `LAN cable not connected.` It means the program will try next attempt, if pwn success it turns off Ethernet interface and shutdown the device.
- `CPPMETHOD="4"` My PS4 (not cursed) crashed a lot when set NEWIPV6 to false, use this method if you can't pwn your PS4.

---------------------------------------------------------------------------------------

## Useful Homebrew

- PS4 file manager : [PS4-Xplorer](https://pkg-zone.com/details/LAPY20009)
- Payload Guest for inject payloads : [Payload Guest](https://github.com/Al-Azif/ps4-payload-guest/releases)
- Save Tool : [Apollo Save Tool](https://github.com/bucanero/apollo-ps4)
- Game Manager : [ItemzFlow](https://github.com/LightningMods/Itemzflow)
- GoldHEN Cheat : [chronoss09](https://github.com/chronoss09/GoldHen-Cheats-PKG/releases)
- PS4's APU Temp Unity : [PS4 Temperature](https://pkg-zone.com/details/LAPY20006)
- Video Player for the PS4 : [PS4 Player](https://pkg-zone.com/details/LAPY20002)
- Great Homebrew from : [Lapy](https://pkg-zone.com/?author=Lapy)
- Emulator : [pEMU](https://github.com/Cpasjuste/pemu/releases)

---------------------------------------------------------------------------------------

## Credit to everyone that made it worked.
