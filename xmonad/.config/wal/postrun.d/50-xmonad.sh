# Restart xmonad
pidof xmonad-x86_64-linux >/dev/null && setsid xmonad --restart &
