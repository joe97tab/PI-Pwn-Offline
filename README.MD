# PI-Pwn-Offline

I rewrited stooged script to using for OFFLINE mode.

Used IPv6, c++ binary from stooged that integrate stage1 and stage2.

Test on PS4 Slim FW 10.50, Raspberry pi 2 and Sunvell T95m S905 TV Box.

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software.

---------------------------------------------------------------------------------------

Current goldhen support       (FW) : 9.00, [9.50, 9.51, 9.60], [10.00, 10.01], 11.00

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

You need to place the goldhen.bin file onto the root of a usb drive and plug it into the console.
Once goldhen has been loaded for the first time it will be copied to the consoles internal hdd and the usb is no longer required.

Current hen support           (FW) : Base on stooged worked.

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



`To update :` On PC copy and replace all files from /update/ to /firmware/PPPwn/.

---------------------------------------------------------------------------------------


##Ready to use installed-image, very easy to setup. Burn image, edit config.sh, test your pwn.


Raspberry pi offline image :

[gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view)


Armbian amlogic s9xx offline image :

[gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view)



`To update this image :` On PC copy and replace all files from /update/ to /firmware/PPPwn/.

---------------------------------------------------------------------------------------
## config.sh, pconfig.sh

| Config | Description |
| --- | --- |
| INTERFACE="eth0" | eth0, eth1, end0, etc |
| FIRMWAREVERSION="10.71" | your current firmware |
| USBETHERNET=false | set to true if using external usb ethernet |


| pconfig | Description |
| --- | --- |
| XFWAP="1" | --wait-after-pin |
| XFGD="4" | --groom-delay |
| XFBS="0" | --buffer-size |
| XFNWB=true | -no-wait-padi , set to false if encounter a problem |

See [xfangfang](https://github.com/xfangfang/PPPwn_cpp) for further details.

---------------------------------------------------------------------------------------

## Credit to everyone that made it worked.
