# PI-Pwn-Offline

I rewrited the script to using device to pwn PS4 for offline mode, most of the idea and the script from [stooged](https://github.com/stooged/PI-Pwn).

Test on PS4 Slim FW 10.50.
- Raspberry pi 2.
- Sunvell T95m S905 2gb/8gb TV Box.
- AIS Playbox v2 S912 2gb/16gb TV Box (not root).

It can use with raspberry pi, armbian devices and some linux system.

For normal version : no need to install additional software, no root required.

For web server version : need pppoe, nginx and php-fpm 8.1 up (8.2 recommend), it requires to connect to internet for installation the package, use my pre-built image make it easier.

The image should no graphic interfaces, CLi, current, default, minimal (at least bookworm or jammy).

What is benifit between normal and web server (my opinion)?

| Pi-Pwn-Offline | Normal | Web Server |
| --- | --- | --- |
| Installation | easy | required internet |
| How fast | faster | slower around 10-15 seconds |
| PPPwn success rate | better | lower |
| Kernel panic | lower | higher |
| Change config | pc | ps4 browser or pc |
| Payloads loader | Payload Guest | ps4 local web page |

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

At PC, Insert SDCARD, create /firmware/PPPwn/ (new raspbian distro /PPPwn/) folder then copy all files from /PPPwn/ to your /PPPwn/ folder.

When boot the device, ssh and installs in terminal with this command :

- Web server version

```sh
sudo bash /boot/firmware/PPPwn/install_web.sh
```

- Normal version

```sh
sudo bash /boot/firmware/PPPwn/install.sh
```

During the install process you will be asked to set some options.

It will create config.sh, pconfig.sh and auto run script for pwn PS4.

### Optional : speed up the boot process.

Reduced boot time and increased overall speed by disable some services.

Please run this script in /tuning/ before install main pppwn script.

Raspbian :

```sh
sudo bash speedup_raspbian.sh
```

Armbian :

```sh
sudo bash speedup_armbian.sh
```

Shut down and connect to ps4 and test your pppwn.

On your PS4:

- Go to `Settings` and then `Network`
- Select `Set Up Internet connection` and choose `Use a LAN Cable`
- Choose `Custom` setup and choose `PPPoE` for `IP Address Settings`
- Enter `ppp` for `PPPoE User ID` and `PPPoE Password`
- Choose `Automatic` for `DNS Settings` and `MTU Settings`
- Choose `Do Not Use` for `Proxy Server`
- You can access web page features at `192.168.2.1` on your PS4 browser when it's not in the pppwn process.

Normally the pwn process will success on first or second attempt.

---------------------------------------------------------------------------------------

## Ready to use pre-build-image.

Very easy to setup. Write image, change config.sh, pconfig.sh then test your pwn.

Lastest update : 30/08/2024

| Offline image | distro | SDCARD | Download |
| --- | --- | --- | --- |
| Raspberry pi | buster (php7.3), up to pi4| 4GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/1.0-final/aml-s9xx-pppwn-offline-v1-bookworm-final.7z) |
| Armbian amlogic | bookworm, s912 may not work | 4GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/1.0-final/aml-s9xx-pppwn-offline-v1-bookworm-final.7z) |
| Armbian amlogic | jammy, s905x3 may not work | 2GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/1.0-final/aml-s9xx-pppwn-offline-v2-jammy-final.7z) |
| Offline web server image | - | - | - |
| Raspberry pi | bookworm (php8.2), up to pi5| 4GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/2.0-beta/rpi-pppwn-offline-bookworm-web-server.7z) |
| Armbian amlogic | bookworm (php8.2), s912 may not work | 4GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/2.0-beta/aml-s9xx-pppwn-offline-bookworm-web-server.7z) |
| Armbian amlogic | jammy (php8.1), s905x3 may not work | 2GB or above | [download](https://github.com/joe97tab/PI-Pwn-Offline/releases/download/2.0-beta/aml-s9xx-pppwn-offline-jammy-web-server.7z) |

If you see "Ready for console connection" it means your device ready for pppwn, please update the lastest script in the section `How to update`.

---------------------------------------------------------------------------------------

## How to update

- At PC, Insert SDCARD.

- Web server version

Copy and replace files `/update/run_web.sh` and `/PPPwn/PPPwn.tar` to your /PPPwn/ folder.

- Normal version

Copy and replace files `/update/run.sh` and `/PPPwn/PPPwn.tar` to your /PPPwn/ folder.

- Power your device, it will auto update and reconfig from previous setup then continue pwn PS4 (no need to reboot).
- If GoldHEN avialable it will auto switch from HEN to GoldHEN.
- If something go wrong, check config.sh and pconfig.sh, use notepad++ to edit your desire value.
- Configuration file templates locate in /tuning/.

Please keep in mind that pwn your PS4 with old IPv6 address is faster than new IPv6.

It's better to use it if your PS4 support.

## config.sh, pconfig.sh

Config file location : SDCARD/firmware/PPPwn/ (new rasbian distro SDCARD/PPPwn)

| config.sh | Description |
| --- | --- |
| CPPMETHOD="3" | 1 = v1 Old IPv6 Only (fastest speed), 2 = stooged binary, 3 = lastest xfangfang binary, 4 = nn9dev binary |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |
| STAGE2METHOD="goldhen" | goldhen, hen, bestpig (10.50 Only) and flow |
| NEWIPV6=false | false = using old IPv6 (faster), true = for cursed ps4 |
| DELAYSTART="0" | delay time before pppwn start, set value between 0-20 seconds |
| For web server version | - |
| SHUTDOWN=false | if enabled this will make the device shutdown after pppwn succeeds |
| PPPOECONN=true | web server setting, only way to enable it if you accidently disabled in ps4 browser |
| PWNAUTORUN=true | set to false if you want manually pwn with ps4 web browser |
| TIMEOUT="5m" | a timeout in minutes to restart pppwn if the exploit hangs mid process |
| PPDBG=true | enables debug output from pppwn so you can see the result after exploited |

`DELAYSTART` uses for adjust your device to ready for pppwn after ps4 finish boot to home screen. 

`CPPMETHOD` If incorrect cpp setup it will use lastest xfangfang binary.

Stooged binary (CPPMETHOD="2") had intregrated stage1, stage2 and hen-vtx into the binary, for hen-vtx, no need to place payload.bin onto the root of a usb drive.

Nn9dev binary (CPPMETHOD="4") added new feature it added spray number, corrupt number and pin number, it hopes to improve stability.

| CPPMETHOD | 1 | 2 | 3 | 4 |
| --- | --- | --- | --- | --- |
| Binary | v1.0.0 xfangfang | stooged | lastest xfangfang | nn9dev |
| Old IPv6 | o | o | o | o |
| New IPv6 | x | o | o | o |
| wait-after-pin | x | o | o | o |
| groom-delay | x | o | o | o |
| buffer-size | x | o | o | o |
| no-wait-padi | x | o | o | o |
| spray number | x | x | x | o |
| corrupt number | x | x | x | o |
| pin number | x | x | x | o |

`STAGE2METHOD` If no stage2 avialable it will use TheOfficialFloW.

| STAGE2METHOD | Description |
| --- | --- |
| goldhen | use goldhen, put goldhen.bin to root of usb drive |
| hen | use vtx-hen, put payload.bin to root of usb drive |
| bestpig | use hen by BestPig, FW 10.50 Only |
| flow | anything not in the above list will use TheOfficialFloW |

If incorrect pconfig setup it will use default value.

| pconfig.sh | Description |
| --- | --- |
| XFWAP="1" | wait-after-pin, set value between 1-20 seconds|
| XFGD="4" | groom-delay, set value between 1-4097 ms |
| XFBS="0" | buffer-size, set value between 0-20480 |
| XFNWB=true | no-wait-padi , set to false if encounter a problem |
| For CPPMETHOD="4" | - |
| SPRAY_NUM="1000" | set value between 400-1500 (1000, 1050, 1100, 1150,... ) |
| CORRUPT_NUM="1" | set value 1, 2, 4, 6, 8, 10, 14, 20, 30, 40 |
| PIN_NUM="1000" | it's fine to leave this at default |

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
- `LAN cable not connected.` It means the program will try next attempt, if pwn success it turns off Ethernet interface and shutdown the device (for normal version).
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
