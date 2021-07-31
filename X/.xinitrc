#!/bin/sh

### Loads on X server start

# Wallpaper: 
setbg &

# Daemons: dunst, sxhkd, picom, etc
xinit-daemons &

# Remaps: caps to escape, keyboard layout switch, etc
xinit-remaps &

# Load Xresources database
xrdb &

# Choose your Window Manager...
exec xmonad 

#exec dwm 
