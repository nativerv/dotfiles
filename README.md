# Dotfiles

My [Stow](https://www.gnu.org/software/stow/) for packages which belong to `$HOME` directory.
User-specific configs, custom desktop entries et cetera go here.

## Installation

Clone the repository:
```sh
git clone https://github.com/nativerv/dotfiles
cd dotfiles
```

Then use GNU `stow` to install packages:
```sh
stow -t ~ <name>[ <name>...]
```
Where `<name>` is name of a directory in the root of this repository.

*WARNING*: not all packages belong to `$HOME` directory! 

Notice that you *must* use `-t ~` flag, otherwise the package will be installed in the parent of your current directory.

## Credits

https://gitlab.com/dwt1/dotfiles - for his `xmonad`/`xmobar` configs, which is basically a miniature documentation of it

https://github.com/ChristianChiarulli/Machfiles - for `zsh` config

https://www.youtube.com/watch?v=gnupOrSEikQ - for `nvim` config
