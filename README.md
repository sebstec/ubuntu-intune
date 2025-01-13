# ubuntu-intune
## installation
run: 

`wget https://raw.githubusercontent.com/sebstec/ubuntu-intune/refs/heads/master/install.sh && chmod 755 ./install.sh && sudo ./install.sh`

and then reboot your system

## note
- it can take a while until newly created user can be used to login to intune-portal

## bonus
replace USER, PASSWORD and IP in following prompt

`xfreerdp /cert:tofu /sound /microphone /d: /u:USER /p:PASSWORD /scale:100 +dynamic-resolution +auto-reconnect +home-drive +clipboard -wallpaper +span '/wm-class:Microsoft Explorer' '/app:program:C:\Windows\explorer.exe,name:Microsoft Explorer' /v:IP
`

and enjoy integration via rdp (some windows settings might be neccessary - see .reg file)
