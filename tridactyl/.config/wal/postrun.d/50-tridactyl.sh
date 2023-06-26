: "${XDG_CACHE_HOME:="${HOME}/.cache"}"
: "${XDG_CONFIG_HOME:="${HOME}/.config"}"

# Copy generated tridactyl theme file
[ -e "${XDG_CONFIG_HOME}/tridactyl" ] && mkdir -p "${XDG_CONFIG_HOME}/tridactyl/themes"
[ -e "${XDG_CONFIG_HOME}/tridactyl" ] && cp -f "${XDG_CACHE_HOME}/wal/tridactyl.css" "${XDG_CONFIG_HOME}/tridactyl/themes/wal.css"
