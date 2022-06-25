#net hydrus-net

# Just in case, seems like it's unused
whitelist ${HOME}/.config/hydrus

# Main hydrus' dir with `aur/hydrus` package
whitelist ${HOME}/.local/share/hydrus

# Leave only hydrus whitelisted in /opt
whitelist /opt/hydrus

# Seen problems with xdg-open, so just in case:
whitelist ${HOME}/.config/mimeapps.list
read-only ${HOME}/.config/mimeapps.list

# Allow media folders
noblacklist ${DOWNLOADS}
whitelist ${DOWNLOADS}

noblacklist ${VIDEOS}
whitelist ${VIDEOS}

noblacklist ${PICTURES}
whitelist ${PICTURES}

# Allow some download folders
noblacklist ${HOME}/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/Desktop
whitelist ${HOME}/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/Desktop

include allow-mpv.inc
include allow-sxiv.inc
include allow-python2.inc
include allow-python3.inc

include disable-common.inc
include disable-programs.inc
include disable-xdg.inc
include disable-passwdmgr.inc
#include /etc/firejail/disable-exec.inc # breaks hydrus when you have python modules installed locally
include disable-interpreters.inc
include disable-devel.inc

include whitelist-common.inc
include whitelist-var-common.inc
include whitelist-usr-share-common.inc

# Attempt to fix sound
whitelist ${RUNUSER}/pulse/native

apparmor
caps.drop all
machine-id
nodvd
nogroups
noinput
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6,netlink
seccomp
tracelog

private-dev

dbus-user none
dbus-system none

# vim:syntax=firejail
