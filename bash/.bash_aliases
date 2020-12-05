alias neofetch="neofetch \
	--ascii_distro windows10 \
	--line_wrap off \
	--bold on \
	--uptime_shorthand on"

alias clr="clear"
alias nv="nvim"
alias update="source ~/.bash_profile"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function mov(){
  mkdir -p $2;
  mv $1 $2;
}

