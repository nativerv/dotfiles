### Loads on X server start

# Set input layounts to us and ru and bind switch to Win-Space
setxkbmap -layout "us,ru" -option "grp:win_space_toggle" -variant qwerty

# Load custom key maps
#xmodmap ~/.Xmodmap

# Remap caps to escape
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape NoSymbol Escape"

# Load wallpapers (nitrogen does that) then load xrdb then replace process with dwm 
nitrogen --restore && \ 
slstatus & \ 
picom &
xrdb & 
exec dwm 
