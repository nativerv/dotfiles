# Firejail profile for chromium
# Description: A web browser built for speed, simplicity, and security
# This file is overwritten after every install/update
# Persistent local customizations
include vieb.local
# Persistent global definitions
include globals.local

mkdir ${HOME}/.cache/Vieb
mkdir ${HOME}/.config/Vieb

ignore private-cache
noblacklist ${HOME}/.cache/Vieb
whitelist ${HOME}/.cache/Vieb

noblacklist ${HOME}/.config/Vieb
whitelist ${HOME}/.config/Vieb

whitelist /opt/Vieb

# private-bin chromium,chromium-browser,chromedriver

# Redirect
include chromium-common.profile
