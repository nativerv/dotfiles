# Dotfiles

My [Stow](https://www.gnu.org/software/stow/) for packages which belong to `$HOME` directory.
User-specific configs, custom desktop entries etc. go here.

## Installation

Clone the repository:
```bash
git clone https://github.com/nativerv/dotfiles dot
cd dot
```
Then use GNU `stow` to install packages:
```bash
stow -t ~ <name>[ <name>...]
```
Where `<name>` is name of a directory in the root of this repository.

**WARNING**: not all packages belong to `$HOME` directory! Most of them do, though.

**WARNING**: you *must* use `-t ~` flag if running outside of `dot` directory, otherwise the package will be installed in the parent of your current directory.

## Credits

Here are some links to places where i got examples/templates, whole unedited configs and inspiration from:

<https://gitlab.com/dwt1/dotfiles> -- for his `xmonad`/`xmobar` configs, which is basically a miniature documentation of it

<https://github.com/ChristianChiarulli/Machfiles> -- for `zsh` config

<https://www.youtube.com/watch?v=gnupOrSEikQ> -- for old (coc/vimscript) `nvim` config and getting me into vim in general

<https://github.com/hlissner/dotfiles/blob/master/modules/themes/alucard/config/dunstrc> - for `dunstrc` config

<https://github.com/LukeSmithxyz/voidrice> -- for various stuff, like `newsboat` or `zathura` configs, and for general inspiration

<https://github.com/deviantfero/wpgtk-templates> -- for `FlatColor` gtk theme and `flattrcolor` icon theme, which power gtk part of my pywal theming

<https://github.com/arkenfox/user.js> -- for their awesome `user.js` which besides hardening
privacy of `firefox` also serves as a `user.js` documentation
