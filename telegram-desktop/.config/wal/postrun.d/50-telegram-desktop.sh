# Regenerate telegram theme
wal-telegram

# Kill and restart telegram-desktop
pidof telegram-desktop >/dev/null &&
  pkill -f telegram-desktop &&
  setsid telegram-desktop -startintray >/dev/null 2>&1 &
