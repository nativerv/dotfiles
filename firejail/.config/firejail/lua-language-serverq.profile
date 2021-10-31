net none

noblacklist /usr/lib/lua-language-server
noblacklist ${HOME}/.config/nvim
noblacklist ${HOME}/.config/firejail
read-only ${HOME}/.config/firejail

include /etc/firejail/allow-lua.inc

#include /etc/firejail/disable-common.inc
#include /etc/firejail/disable-exec.inc
#include /etc/firejail/disable-programs.inc
#include /etc/firejail/disable-shell.inc
