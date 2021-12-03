# Firejail profile for Node.js
# Description: Asynchronous event-driven JavaScript runtime
# This file is overwritten after every install/update
# Persistent local customizations
include php-common.local
# Persistent global definitions
# added by caller profile
#include globals.local

blacklist /tmp/.X11-unix
blacklist ${RUNUSER}

ignore noexec ${HOME}

include allow-bin-sh.inc

include disable-common.inc
include disable-exec.inc
include disable-passwdmgr.inc
include disable-programs.inc
#include disable-shell.inc
include disable-xdg.inc

# If you want whitelisting, change ${HOME}/Projects below to your node projects directory
# and add the next lines to your nodejs-common.local.
include whitelist-common.inc

whitelist /usr/lib/php*
whitelist /usr/include/php*

include whitelist-runuser-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

caps.drop all
ipc-namespace
machine-id
netfilter
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
protocol unix,inet,inet6,netlink
seccomp
seccomp.block-secondary

disable-mnt
private-dev
private-etc alternatives,php,ca-certificates,crypto-policies,group,host.conf,hostname,hosts,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,locale,locale.alias,locale.conf,localtime,login.defs,mime.types,nsswitch.conf,passwd,pki,protocols,resolv.conf,rpc,services,ssl,xdg
#private-tmp

dbus-user none
dbus-system none

# vim:syntax=firejail
