source ~/.zplug/init.zsh


###########
# PLUGINS #
###########

# Git
zplug "plugins/git", from:oh-my-zsh

# Enhancd
zplug "b4b4r07/enhancd", use:init.sh

###############
# Final Setup #
###############

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Source Plugins & Add Commands to Path
zplug load
