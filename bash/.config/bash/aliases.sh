alias neofetch="neofetch \
	--line_wrap off \
	--bold on \
	--uptime_shorthand on"

alias clr="clear"
alias nv="nvim"

alias update="source ~/.bash_profile"
alias nvplug="nvim +PlugInstall"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


function mov(){
  mkdir -p $2;
  mv $1 $2;
}

