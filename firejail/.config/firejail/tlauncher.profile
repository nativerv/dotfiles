# Firejail profile for tlauncher
# Description: Unofficial Minecraft launcher
# This file is overwritten after every install/update
# Persistent local customizations
include minecraft-launcher.local
# Persistent global definitions
include globals.local

# Some distros put the executable in /opt/minecraft-launcher.
# Run 'firejail /opt/minecraft-launcher/minecraft-launcher' to start it.

# Allow tlauncher.jar
ignore noexec ${HOME}

# Allow mc dir
noblacklist ${HOME}/.local/share/tlauncher
mkdir ${HOME}/.local/share/tlauncher
whitelist ${HOME}/.local/share/tlauncher

noblacklist ${HOME}/.tlauncher
mkdir ${HOME}/.tlauncher
whitelist ${HOME}/.tlauncher

blacklist /srv
blacklist /media

include allow-java.inc
include allow-bin-sh.inc

include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-shell.inc
include disable-xdg.inc

include whitelist-common.inc
include whitelist-runuser-common.inc
include whitelist-usr-share-common.inc
include whitelist-var-common.inc

caps.drop all
netfilter
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
shell none
tracelog

disable-mnt
private-bin java,java-config,tlauncher,tree,ls,bash,sh,zsh
private-cache
private-dev
# If multiplayer or realms break, add 'private-etc <your-own-java-folder-from-/etc>'
# or 'ignore private-etc' to your minecraft-launcher.local.
private-etc alternatives,asound.conf,ati,ca-certificates,crypto-policies,drirc,fonts,group,gtk-2.0,gtk-3.0,host.conf,hostname,hosts,java-10-openjdk,java-11-openjdk,java-12-openjdk,java-13-openjdk,java-14-openjdk,java-7-openjdk,java-8-openjdk,java-9-openjdk,java-openjdk,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,localtime,login.defs,machine-id,mime.types,nvidia,passwd,pki,pulse,resolv.conf,selinux,services,ssl,timezone,X11,xdg
#private-opt tlauncher
blacklist /opt
private-tmp

dbus-user none
dbus-system none
