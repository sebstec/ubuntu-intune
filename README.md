# ubuntu-intune
## installation
run: 

`wget https://raw.githubusercontent.com/sebstec/ubuntu-intune/refs/heads/master/install.sh && chmod 755 ./install.sh && ./install.sh`

and then reboot your system

## note
- it can take a while until newly created user can be used to login to intune-portal
- if conditional access is used:
    - intune portal must be excluded to sync settings with intune and check for compliance
    - for the initial call-in by intune portal, some more endpoints must be excluded (TODO: find out what that is - i just disabled conditional access for linux devices to do the setup but that might not be possible)

## seamless rdp
replace USER, PASSWORD and IP in following prompt

`xfreerdp /cert:tofu /sound /microphone /d: /u:USER /p:PASSWORD /scale:100 +dynamic-resolution +auto-reconnect +home-drive +clipboard -wallpaper +span '/wm-class:Microsoft Explorer' '/app:program:C:\Windows\explorer.exe,name:Microsoft Explorer' /v:IP
`

and enjoy integration via rdp (some windows settings might be necessary - see files in app-scripts/windows/oem)

### note: if the home drive is already mounted via docker/qemu or some other way, the home-drive sharing via rdp is not necessary
