JWHITING_ZSH_DIR=$(dirname $(realpath ${(%):-%N}))
JWHITING_DIR=$(dirname ${JWHITING_ZSH_DIR})

fpath=(${JWHITING_ZSH_DIR}/prompts $fpath)

source ${JWHITING_ZSH_DIR}/base.zsh
source ${JWHITING_ZSH_DIR}/environment.zsh
source ${JWHITING_ZSH_DIR}/utilities.zsh
source ${JWHITING_ZSH_DIR}/zplug.zsh
source ${JWHITING_ZSH_DIR}/keybinds.zsh
source ${JWHITING_ZSH_DIR}/theme.zsh
source ${JWHITING_ZSH_DIR}/aliases/init.zsh
