I modify the script to using for OFFLINE mode.
Test on PS4 Slim FW 10.50, Raspberry pi 2 and Sunvell T95m S905 TV Box.
It can use with raspberry pi, linux system and armbian devices (tested on TV Box).
No need to install additional software.

Current goldhen support       (FW) : 9.00, [10.00, 10.01], 11.00
https://github.com/GoldHEN/GoldHEN/releases

Current hen (BestPig) support (FW) : [10.50, 10.70, 10.71], 11.00
https://github.com/BestPig/ps4-hen-vtx/releases

Current hen support           (FW) : [8.00, 8.01, 8.03], [9.03, 9.04], [9.50, 9.51, 9.60], [10.50, 10.70, 10.71], 11.00
https://github.com/EchoStretch/ps4-hen-vtx/releases

Current pppwn support         (FW) : 7.00 - 11.00
FW 7.00 / 7.01 / 7.02
FW 7.50 / 7.51 / 7.55
FW 8.00 / 8.01 / 8.03
FW 8.50 / 8.52
FW 9.00
FW 9.03 / 9.04
FW 9.50 / 9.51 / 9.60
FW 10.00 / 10.01
FW 10.50 / 10.70 / 10.71
FW 11.00

I provided some bin files for your test in folder /stage2/, replace new stage2_xx.xx.bin in /firmware/PPPwn/ to match your firmware.
When pwn the console don't touch anything it will increase the success rate.

How to install
	Copy file from /PPPwn/ to /firmware/PPPwn/.
	Install with this command :
		sudo bash /boot/firmware/PPPwn/install.sh

Raspberry pi offline image :
https://drive.google.com/file/d/1B77cpOlqDezk_ZGb8Iq76Zwk2XyXiXLm/view

Armbian amlogic s9xx offline image :
https://drive.google.com/file/d/1lJDEnSDJddFn1aSHEMuiIIfhtkltQSNp/view

Credit to anyone that made it worked.
