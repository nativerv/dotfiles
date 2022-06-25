# Firejail profile for umodel (based on profile for blender)
# Description: Extract models from Unreal Engine games
# Persistent local customizations
include umodel.local
# Persistent global definitions
include globals.local

# Allow exec in ${HOME}
ignore noexec ${HOME}
ignore noexec /home

# Allow app dirs
noblacklist ${HOME}/.config/umodel
whitelist ${HOME}/.config/umodel
noblacklist ${HOME}/.local/share/umodel
whitelist ${HOME}/.local/share/umodel

# Allow games dir
noblacklist /media/win_d_drive/vg
whitelist /media/win_d_drive/vg 
noblacklist ${HOME}/vg
whitelist ${HOME}/vg 

# Allow python (blacklisted by disable-interpreters.inc)
include allow-python2.inc
include allow-python3.inc

include disable-common.inc
include disable-devel.inc
#include disable-exec.inc
include disable-interpreters.inc
include disable-programs.inc

# Allow usage of AMD GPU by OpenCL
noblacklist /sys/module
whitelist /sys/module/amdgpu
read-only /sys/module/amdgpu

caps.drop all
netfilter
nodvd
nogroups
noinput
nonewprivs
noroot
notv
nou2f
protocol unix,inet,inet6,netlink
# numpy, used by many add-ons, requires the mbind syscall
seccomp !mbind
shell none

private-dev
