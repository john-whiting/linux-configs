JWHITING_ZSH_DIR=$(dirname $(realpath ${(%):-%N}))
JWHITING_DIR=$(dirname ${JWHITING_ZSH_DIR})
JWHITING_LOCAL_DIR=${JWHITING_DIR}/.local

fpath=(${JWHITING_ZSH_DIR}/prompts $fpath)

source ${JWHITING_ZSH_DIR}/base.zsh
source ${JWHITING_ZSH_DIR}/async_prompt.zsh
source ${JWHITING_ZSH_DIR}/environment.zsh
source ${JWHITING_ZSH_DIR}/utilities.zsh
source ${JWHITING_ZSH_DIR}/zplug.zsh
source ${JWHITING_ZSH_DIR}/keybinds.zsh
source ${JWHITING_ZSH_DIR}/theme.zsh
source ${JWHITING_ZSH_DIR}/aliases/init.zsh

source ${JWHITING_ZSH_DIR}/zoxide.zsh

if [ -d "${JWHITING_LOCAL_DIR}/zsh" ]; then
	for f in ${JWHITING_LOCAL_DIR}/zsh/*.zsh; do
  		. $f
	done
fi


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# pnpm
export PNPM_HOME="/home/john/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/john/.bun/_bun" ] && source "/home/john/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
