# Firejail profile for chromium
# Description: A web browser built for speed, simplicity, and security
# This file is overwritten after every install/update
# Persistent local customizations
include vieb.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/vieb
noblacklist ${HOME}/.config/vieb
#noblacklist ${HOME}/.config/chromium-flags.conf

mkdir ${HOME}/.cache/vieb
mkdir ${HOME}/.config/vieb
whitelist ${HOME}/.cache/vieb
whitelist ${HOME}/.config/vieb
#whitelist ${HOME}/.config/chromium-flags.conf
whitelist /opt/Vieb

# private-bin chromium,chromium-browser,chromedriver

# Redirect
include chromium-common.profile
