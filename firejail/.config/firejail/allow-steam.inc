# Allow java (blacklisted by disable-devel.inc)
include allow-java.inc

# Allow python (blacklisted by disable-interpreters.inc)
include allow-python2.inc
include allow-python3.inc

noblacklist ${HOME}/.local/share/Steam
whitelist ${HOME}/.local/share/Steam

noblacklist ${HOME}/.steam
whitelist ${HOME}/.steam

noblacklist ${HOME}/.steampath
whitelist ${HOME}/.steampath

noblacklist ${HOME}/.steampid
whitelist ${HOME}/.steampid

# vim:syntax=firejail
