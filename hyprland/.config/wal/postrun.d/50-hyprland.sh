# Source wal colors to Hyprland
hyprctl keyword source "${XDG_CACHE_HOME}/wal/hyprland.conf"

# Copy the file anyway because hyprland needs something at reload/startup
cp -f "${XDG_CACHE_HOME}/wal/hyprland.conf" "${XDG_CONFIG_HOME}/hypr/colors.conf"
