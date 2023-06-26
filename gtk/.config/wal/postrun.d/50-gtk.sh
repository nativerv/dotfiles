: "${XDG_CACHE_HOME:="${HOME}/.cache"}"
: "${XDG_DATA_HOME:="${HOME}/.local/share"}"

# Copy generated gtk theme files
cp -f "${XDG_CACHE_HOME}/wal/flatcolor-gtk-2.0.gtkrc" "${XDG_DATA_HOME}/themes/FlatColor/gtk-2.0/gtkrc"
cp -f "${XDG_CACHE_HOME}/wal/flatcolor-gtk-3.0.css" "${XDG_DATA_HOME}/themes/FlatColor/gtk-3.0/gtk.css"
cp -f "${XDG_CACHE_HOME}/wal/flatcolor-gtk-3.20.css" "${XDG_DATA_HOME}/themes/FlatColor/gtk-3.20/gtk.css"
