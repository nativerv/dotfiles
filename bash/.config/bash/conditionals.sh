# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Make `less` more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If tmux session present, attach to it, else spawn new
if [[ $TERM != "screen" ]]; then
  export TERM="xterm-256color"

  tmux has-session -t main

  if [ $? != 0 ]
  then
    tmux new-session -s main
  fi

  tmux attach -t main  

  clear
fi