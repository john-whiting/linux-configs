#!/bin/bash



##
# Helper Functions
##

SCRIPT=$(realpath "$0")
SCRIPT_PATH=$(dirname "$SCRIPT")

bind_config() {
	FROM_PATH=$1
	TO_PATH=$SCRIPT_PATH/$2
	echo "Binding config for $FROM_PATH to $TO_PATH"

	TO_DIR=$(dirname $TO_PATH)

	mkdir $TO_DIR -p

	rm $FROM_PATH.old &> /dev/null
	mv $FROM_PATH $FROM_PATH.old &> /dev/null
	ln -s $TO_PATH $FROM_PATH
}



##
# Primary Logic
##

install_nvim() {
	# Remove the configurations/state files
	rm ~/.config/nvim -r
	rm ~/.local/share/nvim
	rm ~/.local/state/nvim

	# Remove the installation
	rm ~/.nvim -r

	# Install neovim
	mkdir -p ~/.nvim

	wget -qO- https://github.com/neovim/neovim/releases/download/v0.9.2/nvim-linux64.tar.gz | tar xvz -C ~/.nvim

	mv ~/.nvim/nvim-linux64/* ~/.nvim
	rm ~/.nvim/nvim-linux64 -r

	# Bind nvim config
	ln -s $SCRIPT_PATH/nvim ~/.config/nvim
}

install_packages() {
	##
	# Ensure Repositories are up to date
	# and install required packages:
	# Packages include:
	# - ZSH
	# - Neovim
	# - Ripgrep
	##
	echo "Installing Packages"

	sudo apt update -y
	sudo apt install -y zsh ripgrep fzy

	install_nvim

	echo "Finished Installing Packages"
}

bind_configs() {
	##
	# Bind the necessary configs
	##
	echo "Binding Configs"

	# ZSH Config
	bind_config ~/.zshrc zsh/init.zsh

	echo "Finished Binding Configs"
}

install_plugins() {
    # Install NeoVim Plugins
    ~/.nvim/bin/nvim --headless "+Lazy! sync" +qa
}


##
# Main
##

main() {
	echo "Installing JWHITING's Terminal Setup"

	install_packages
	bind_configs
	install_plugins

	echo "Finished Installing JWHITING's Terminal Setup"
}

main
