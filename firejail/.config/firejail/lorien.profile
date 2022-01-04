# Firejail profile for lorien
# Description: -
# This file is overwritten after every install/update
# Persistent local customizations
include lorien.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/lorien
whitelist ${HOME}/.config/lorien

noblacklist ${HOME}/.local/share/lorien
whitelist ${HOME}/.local/share/lorien

noblacklist ${PICTURES}
noblacklist ${HOME}/pix/lorien
mkdir ${HOME}/pix/lorien
whitelist ${HOME}/pix/lorien

include whitelist-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

# Allow python (blacklisted by disable-interpreters.inc)
include allow-python2.inc
include allow-python3.inc

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
netfilter
#no3d
nodvd
nogroups
noinput
nonewprivs
noroot
nosound
notv
nou2f
novideo
protocol unix,inet,inet6,netlink
seccomp
shell none
tracelog

private-cache
private-dev
private-etc alsa,alternatives,asound.conf,ca-certificates,crypto-policies,drirc,fonts,machine-id,mono,nsswitch.conf,openal,pki,pulse,resolv.conf,ssl
private-tmp

dbus-user none
dbus-system none
