# Firejail profile for ssh
# Description: Secure shell client and server
# This file is overwritten after every install/update
#quiet
# Persistent local customizations
include s.local
# Persistent global definitions
include globals.local

include disable-common.inc
include disable-exec.inc
include disable-programs.inc

include whitelist-usr-share-common.inc
include whitelist-runuser-common.inc

whitelist /usr/share/doc/s
whitelist /usr/share/licenses/s

apparmor
caps.drop all
ipc-namespace
netfilter
no3d
nodvd
nogroups
noinput
nonewprivs
# noroot - see issue #1543
nosound
notv
# nou2f - OpenSSH >= 8.2 supports U2F
novideo
protocol unix,inet,inet6
seccomp
shell none
tracelog

private-cache
private-dev
private-tmp

dbus-user none
dbus-system none

deterministic-shutdown
memory-deny-write-execute
