net none

# This fixes:
# `Error: no suitable /tmp/yarn--1635026745180-0.7119542057973685/node executable found`
ignore noexec /tmp
noblacklist /tmp

# Allow my stuff
noblacklist ${HOME}/pr
whitelist ${HOME}/pr

noblacklist ${HOME}/edu
whitelist ${HOME}/edu

noblacklist ${HOME}/dot
whitelist ${HOME}/dot
read-only ${HOME}/dot

# ---------------

blacklist /tmp/.X11-unix
blacklist ${RUNUSER}

ignore noexec ${HOME}

include /etc/firejail/allow-bin-sh.inc
include /etc/firejail/allow-lua.inc

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-exec.inc
include /etc/firejail/disable-passwdmgr.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-shell.inc
include /etc/firejail/disable-xdg.inc

whitelist /usr/share/doc/lua
whitelist /usr/share/lua*

include /etc/firejail/whitelist-runuser-common.inc
include /etc/firejail/whitelist-usr-share-common.inc
include /etc/firejail/whitelist-var-common.inc

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
shell none

disable-mnt
private-dev
private-etc alternatives,ca-certificates,crypto-policies,group,host.conf,hostname,hosts,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,locale,locale.alias,locale.conf,localtime,login.defs,mime.types,nsswitch.conf,passwd,protocols,resolv.conf,rpc,services,xdg
#private-tmp

dbus-user none
dbus-system none

# vim:syntax=firejail
