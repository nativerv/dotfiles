include allow-lua.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

noblacklist ${HOME}/.config/mpv
whitelist ${HOME}/.config/mpv
read-only ${HOME}/.config/mpv

noblacklist ${HOME}/.config/mpv/input.conf
whitelist ${HOME}/.config/mpv/input.conf
read-only ${HOME}/.config/mpv/input.conf

noblacklist ${HOME}/.config/mpv/input.conf
whitelist ${HOME}/.config/mpv/input.conf
read-only ${HOME}/.config/mpv/input.conf

noblacklist ${HOME}/.config/youtube-dl
whitelist ${HOME}/.config/youtube-dl
read-only ${HOME}/.config/youtube-dl

whitelist /usr/share/lua
whitelist /usr/share/lua*
whitelist /usr/share/vulkan

# vim:syntax=firejail
