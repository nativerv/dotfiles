noblacklist ${HOME}/dot
whitelist ${HOME}/dot
read-only ${HOME}/dot

noblacklist ${HOME}/.Xauthority
whitelist ${HOME}/.Xauthority
noblacklist /tmp/.X11-unix
whitelist /tmp/.X11-unix
noblacklist /tmp/.ICE-unix
whitelist /tmp/.ICE-unix

include allow-mpv.inc

include nodejs-common.profile
