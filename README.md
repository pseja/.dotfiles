# Dotfiles
This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

## Requirements
You'll need to install these manually first:
- [**Nerd Font**](https://www.nerdfonts.com/)
- [**Neovim**](https://github.com/neovim/neovim/releases) - version `0.12.0` or higher (has `vim.pack` available)

## Installation
```bash
git clone --recursive https://github.com/pseja/.dotfiles ~/.dotfiles
cd ~/.dotfiles
bash setup.sh
stow --adopt .
```

For pulling, you need to `git pull && git submodule update --init --recursive` or `git config submodule.recurse true`, and then just `git pull` is fine.
