#!/bin/bash

##
# Helper Functions
##

INSTALL_PATH=${INSTALL_PATH:=~/.jwhiting}

bind_config() {
  FROM_PATH=$1
  TO_PATH=$INSTALL_PATH/$2
  echo "Binding config for $FROM_PATH to $TO_PATH"

  TO_DIR=$(dirname $TO_PATH)

  mkdir $TO_DIR -p

  rm $FROM_PATH.old &> /dev/null
  mv $FROM_PATH $FROM_PATH.old &> /dev/null
  ln -s $TO_PATH $FROM_PATH
}

check_fail() {
  if [ $? -ne 0 ]; then
    echo $1
    exit 1
  fi
}

##
# Primary Logic
##

pull_github() {
  if [ ! -d $INSTALL_PATH/.git ]; then
    echo "Cloning repository"
    git clone git@github.com:john-whiting/linux-configs.git $INSTALL_PATH &> /dev/null

    if [ $? -ne 0 ]; then
      git clone https://github.com/john-whiting/linux-configs.git $INSTALL_PATH &> /dev/null
    fi

    check_fail "Failed to pull repository"

    cd $INSTALL_PATH

    echo "Finished cloning repository"
  else
    echo "Updating existing repository"

    cd $INSTALL_PATH

    git pull

    check_fail "Failed to update repository"

    echo "Finished updating existing repository"
  fi
}

install_nvim() {
  echo "Installing neovim"
  # Remove the configurations/state files
  rm ~/.config/nvim -r &> /dev/null
  rm ~/.local/share/nvim &> /dev/null
  rm ~/.local/state/nvim &> /dev/null

  # Remove the installation
  rm ~/.nvim -r &> /dev/null

  # Install neovim
  mkdir -p ~/.nvim

  wget -qO- https://github.com/neovim/neovim/releases/download/v0.9.2/nvim-linux64.tar.gz | tar xvz -C ~/.nvim > /dev/null

  echo "Failed to install neovim"

  mv ~/.nvim/nvim-linux64/* ~/.nvim
  rm ~/.nvim/nvim-linux64 -r

  # Bind nvim config
  mkdir -p ~/.config
  ln -s $INSTALL_PATH/nvim ~/.config/nvim
  echo "Finished installing neovim"
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

  sudo apt update -y > /dev/null
  sudo apt install -y zsh ripgrep fzy > /dev/null

  # Install ZPlug for ZSH plugins
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

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
  echo "Installing plugins"
  # Install NeoVim Plugins
  ~/.nvim/bin/nvim --headless "+Lazy! sync" +qa > /dev/null
  check_fail "Failed to install Neovim plugins."
  echo "Finished installing plugins"
}

##
# Main
##

main() {
  echo "Installing JWHITING's Terminal Setup"

  pull_github
  install_packages
  bind_configs
  install_plugins

  echo "Finished Installing JWHITING's Terminal Setup"
}

main
