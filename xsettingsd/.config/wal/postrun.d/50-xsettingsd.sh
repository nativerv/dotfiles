# Kill and restart xsettingsd
# xsettingsd as a daemon does not work at all or with firefox specifically
# for some reason; it requires to be run every time gtk theme updates,
# and older instance can recognize that another one was run and kill itself,
# but firefox just don't care, so we kill xsettingsd then run a new one
command -v 'xsettingsd' >/dev/null 2>&1 &&
  pkill xsettingsd >/dev/null 2>&1 &&
  setsid xsettingsd -c "${XDG_CONFIG_HOME}/xsettingsd/xsettingsd.conf" >/dev/null 2>&1 &
