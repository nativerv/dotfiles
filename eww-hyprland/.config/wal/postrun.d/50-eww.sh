#!/bin/sh

cp -f "${XDG_CACHE_HOME}/wal/colors.scss" "${XDG_CONFIG_HOME}/eww/wal.scss"

eww reload
