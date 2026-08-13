#!/bin/bash
set -e

# general package names
pkgs=(
	bat	    # cat replacement
	btop    # resource monitor
    cmake
	curl	# for downloading install scripts
	eza	    # ls replacement
	fzf	    # fuzzy finder
    git
    make
	ripgrep	# search tool
	stow    # symlink manager
	wget	# for downloading install scripts
	zsh	    # shell
)

# distro specific package names
arch_pkgs=(
    base-devel
	nodejs
	nvm    # node version manager
)
ubuntu_pkgs=(
	build-essential
)

get_nvm_node() {
	echo "Installing nvm and Node.js (LTS)..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
	. "$HOME/.config/nvm/nvm.sh"
	nvm install 24
}

install_packages() {
	if command -v apt &> /dev/null; then
		sudo apt update && sudo apt upgrade
		sudo apt install "${pkgs[@]}" "${ubuntu_pkgs[@]}"
		get_nvm_node
	elif command -v pacman &> /dev/null; then
		sudo pacman -Syu --needed "${pkgs[@]}" "${arch_pkgs[@]}"
	else
		echo "Error: Unsupported distribution."
		exit 1
	fi
}

adopt() {
	stow --adopt .
}

set_zsh_default() {
	local zsh_path=$(which zsh)

	if ! grep -Fxq "$zsh_path" /etc/shells; then
		echo "Adding $zsh_path to /etc/shells..."
		echo "$zsh_path" | sudo tee -a /etc/shells
	fi

	sudo chsh -s "$zsh_path" "$USER"

	echo "Reboot to use the new default shell. Confirm it with 'echo \$SHELL'"
}

get_starship() {
	echo "Installing Starship (cross-shell customizable prompt)"
	curl -sS https://starship.rs/install.sh | sh
}

get_pyenv() {
    echo "Installing Pyenv"
    curl -fsSL https://pyenv.run | bash
}

get_herdr() {
    echo "Installing Herdr"
    curl -fsSL https://herdr.dev/install.sh | sh
}

get_opencode() {
    echo "Installing OpenCode"
    curl -fsSL https://opencode.ai/install | bash
}

get_all() {
    get_opencode
    get_pyenv
    get_herdr
    get_opencode
}

main() {
	install_packages
	adopt

	set_zsh_default

	get_all
}

main

