# Neovim Shortcuts
alias nv="nvim -p"

# ZSH Shortcuts
alias zsh-reload="source ~/.zshrc"

#
alias eth0_ip="ip addr show eth0 | grep \"inet\\b\" | awk '{print \$2}' | cut -d/ -f1"

# Open the PWD inside of Windows Explorer
openinwin() {
  DIRECTORY=${$(pwd)//\//\\\\}
  explorer.exe "\\\\wsl.localhost\\${WSL_DISTRO_NAME}$(echo $DIRECTORY)"
}
