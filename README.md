# Dotfiles
This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

## Requirements
You'll need to install these manually first:
- [**Nerd Font**](https://www.nerdfonts.com/)
- [**Neovim**](https://github.com/neovim/neovim/releases) - version `0.12.0` or higher

## Installation
```bash
git clone https://github.com/pseja/.dotfiles ~/.dotfiles
cd ~/.dotfiles
bash setup.sh
stow --adopt .
```
