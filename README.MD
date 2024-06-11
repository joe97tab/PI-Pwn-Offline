# PI-Pwn-Offline

I modify the script to using for OFFLINE mode.

Test on PS4 Slim FW 10.50, Raspberry pi 2 and Sunvell T95m S905 TV Box.

It can use with raspberry pi, armbian devices and linux system.

No need to install additional software.

---------------------------------------------------------------------------------------

- Current goldhen support       (FW) : 9.00, [10.00, 10.01], 11.00

[GoldHEN](https://github.com/GoldHEN/GoldHEN/releases)

- Current hen (BestPig) support (FW) : [10.50, 10.70, 10.71], 11.00

[BestPig](https://github.com/BestPig/ps4-hen-vtx/releases)

- Current hen support           (FW) : [8.00, 8.01, 8.03], [9.03, 9.04], [9.50, 9.51, 9.60], [10.50, 10.70, 10.71], 11.00

[hen-vtx](https://github.com/EchoStretch/ps4-hen-vtx/releases)

- Current pppwn support         (FW) : 7.00 - 11.00

`stage2_7.00.bin` = FW 7.00 / 7.01 / 7.02

`stage2_7.50.bin` = FW 7.50 / 7.51 / 7.55

`stage2_8.00.bin` = FW 8.00 / 8.01 / 8.03

`stage2_8.50.bin` = FW 8.50 / 8.52

`stage2_9.00.bin` = FW 9.00

`stage2_9.03.bin` = FW 9.03 / 9.04

`stage2_9.50.bin` = FW 9.50 / 9.51 / 9.60

`stage2_10.00.bin` = FW 10.00 / 10.01

`stage2_10.50.bin` = FW 10.50 / 10.70 / 10.71

`stage2_11.00.bin` = FW 11.00

I provided some bin files for your test in folder /stage2/, replace new stage2_xx.xx.bin in /firmware/PPPwn/ to match your firmware.

When pwn the console don't touch anything it will increase the success rate.

---------------------------------------------------------------------------------------


## How to install :

Copy all files from /PPPwn/ to /firmware/PPPwn/.

Install with this command :

```sh
sudo bash /boot/firmware/PPPwn/install.sh
```

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



`To update :` copy all files from /PPPwn/ to /firmware/PPPwn/.

---------------------------------------------------------------------------------------


##Ready to use installed-image, very easy to setup. Burn image, edit config.sh, test your pwn.


Raspberry pi offline image :

[gdrive](https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view)


Armbian amlogic s9xx offline image :

[gdrive](https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view)



`To update this image :` copy all files from /PPPwn/ to /firmware/PPPwn/.



## Credit to everyone that made it worked.
