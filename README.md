# My dotfiles

This repository contains configuration, script, binary, alias files that i use.

## Installation

Use GNU stow to symlink packages to corresponding places.

WARNING: not all packages belong to `$HOME` directory! 

```sh
git clone https://github.com/nativerv/dotfiles.git
cd dotfiles
stow -t ~/ bash git htop neofetch npm nvim tmux 
stow -t /usr/local/share keymaps
```
