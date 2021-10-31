# Description: A fast and easy graphics application for digital painters
# This file is overwritten after every install/update
# Persistent local customizations
include mypaint.local
# Persistent global definitions
include globals.local

# Allow mypaint dirs (blacklisted by disable-programs.inc)
noblacklist ${HOME}/.config/mypaint
noblacklist ${HOME}/.local/share/mypaint
noblacklist ${HOME}/.cache/mypaint

# Whitelist them just in case so everything else is blocked
whitelist ${HOME}/.cache/mypaint
whitelist ${HOME}/.config/mypaint
whitelist ${HOME}/.local/share/mypaint

# Allow XDG Pictures Dir
noblacklist ${PICTURES}
whitelist ${PICTURES}

# Allow executing ${HOME} (blacklisted by disable-exec.inc)
ignore noexec ${HOME}

# Allow python (blacklisted by disable-interpreters.inc)
include /etc/firejail/allow-python2.inc
include /etc/firejail/allow-python3.inc

whitelist /usr/share/mypaint*
include whitelist-usr-share-common.inc

include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-xdg.inc

apparmor
caps.drop all
machine-id
net none
no3d
nodvd
nogroups
noinput
nonewprivs
noroot
nosound
notv
nou2f
novideo
protocol unix
seccomp
shell none
tracelog

private-cache
private-dev
private-etc alternatives,dconf,fonts,gtk-3.0
private-tmp

dbus-user none
dbus-system none

# vim:syntax=firejail
