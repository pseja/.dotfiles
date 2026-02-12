#!/bin/bash

# general package names
pkgs=(
	bat	# cat replacement
	btop	# resource monitor
	fzf	# fuzzy finder
	nvim	# text editor
	ripgrep	# search tool
	stow	# symlink manager
	zsh	# shell
)

# distro specific package names
arch_pkgs=(
	eza	# ls replacement
	nodejs	# for nvim copilot
)
ubuntu_pkgs=(
	# nodejs - TODO: https://www.reddit.com/r/MeshCentral/comments/1kkhnas/whats_the_command_to_install_node_on_ubuntu/
	# eza - TODO: https://dario.griffo.io/posts/how-to-install-updated-eza-in-debian/
)

install_packages() {
	if command -v apt &> /dev/null; then
		sudo apt update && sudo apt upgrade
		sudo apt install "${pkgs[@]}" "${ubuntu_pkgs[@]}"
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

main() {
	install_packages
	adopt

	set_zsh_default

	get_starship
}

main
