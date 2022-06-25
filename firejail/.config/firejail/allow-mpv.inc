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

noblacklist ${HOME}/.config/mpv
noblacklist ${HOME}/.config/youtube-dl
noblacklist ${HOME}/.config/yt-dlp
noblacklist ${HOME}/.config/yt-dlp.conf
noblacklist ${HOME}/.netrc
noblacklist ${HOME}/yt-dlp.conf
noblacklist ${HOME}/yt-dlp.conf.txt

# Allow lua (blacklisted by disable-interpreters.inc)
include allow-lua.inc

# Allow python (blacklisted by disable-interpreters.inc)
include allow-python2.inc
include allow-python3.inc

blacklist /usr/libexec

whitelist ${HOME}/.config/mpv
whitelist ${HOME}/.config/youtube-dl
whitelist ${HOME}/.config/yt-dlp
whitelist ${HOME}/.config/yt-dlp.conf
whitelist ${HOME}/.netrc
whitelist ${HOME}/yt-dlp.conf
whitelist ${HOME}/yt-dlp.conf.txt
whitelist /usr/share/lua
whitelist /usr/share/lua*
whitelist /usr/share/vulkan
include whitelist-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

# vim:syntax=firejail
