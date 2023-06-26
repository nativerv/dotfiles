# Reload nvim - send signal (nvim config must handle the signal)
pidof nvim >/dev/null && killall -USR1 nvim
