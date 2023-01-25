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

	mkdir -p $TO_DIR

	rm $FROM_PATH.old &> /dev/null
	mv $FROM_PATH $FROM_PATH.old &> /dev/null
	ln -s $TO_PATH $FROM_PATH
}



##
# Primary Logic
##

install_packages() {
	##
	# Ensure Repositories are up to date
	# and install required packages:
	# Packages include:
	# - ZSH
	# - Neovim
	# - Ripgrep
	# - Vim-Plug
	# - Z-Plug
	##
	echo "Installing Packages"

	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt update -y
	sudo apt install -y zsh neovim-runtime neovim ripgrep

	# Install Vim-Plug
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &> /dev/null
	
	# Install Z-Plug
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

	echo "Finished Installing Packages"
}

bind_configs() {
	##
	# Bind the necessary configs
	##
	echo "Binding Configs"

	# ZSH Config
	bind_config ~/.zshrc zsh/init.zsh
	bind_config ~/.config/nvim/init.vim nvim/init.vim

	echo "Finished Binding Configs"
}

install_plugins() {
	# Install NeoVim Plugins
    nv --headless +'PlugInstall' +qa
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
