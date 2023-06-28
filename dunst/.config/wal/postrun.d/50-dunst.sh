#!/bin/sh

: "${XDG_CONFIG_HOME:="${HOME}/.config"}"
: "${XDG_DATA_HOME:="${HOME}/.local/share"}"
: "${XDG_CACHE_HOME:="${HOME}/.cache"}"

# Copy wal dunstrc (symlinks are unsupported)
cp -f "${XDG_CACHE_HOME}/wal/dunstrc" "${XDG_CONFIG_HOME}/dunst/dunstrc.d/50-wal.conf"

# Restart dunst -- if using systemd
# FIXME: dunst user service is activating on the dbus interface (not display-aware)
# command -v systemctl >/dev/null 2>&1 && \
#   systemctl --user restart "dunst@${DISPLAY#:*}.service"
(
  sleep 2 &&
    command -v 'systemctl' >/dev/null 2>&1 &&
    systemctl --user restart "dunst.service"
) &
