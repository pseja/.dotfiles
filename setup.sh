#!/bin/bash

# general package names
pkgs=(
	bat	# cat replacement
	btop	# resource monitor
	exa	# ls replacement
	fzf	# fuzzy finder
	nvim	# text editor
	ripgrep	# search tool
	stow	# symlink manager
	zsh	# shell
)

# distro specific package names
arch_pkgs=(
	nodejs	# for nvim copilot
)
ubuntu_pkgs=(
	# nodejs - TODO: https://www.reddit.com/r/MeshCentral/comments/1kkhnas/whats_the_command_to_install_node_on_ubuntu/
)

install_packages() {
	if command -v apt &> /dev/null; then
		sudo apt update && sudo apt upgrade
		sudo apt install "${pkgs[@]}" "${ubuntu_pkgs[@]}"
	elif command -v pacman &> /dev/null; then
		sudo pacman -Syu "${pkgs[@]}" "${arch_pkgs[@]}"
	else
		echo "Error: Unsupported distribution."
		exit 1
	fi
}

adopt() {
	stow --adopt .
}

main() {
	install_packages
	adopt
}

main
