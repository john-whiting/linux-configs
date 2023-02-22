# keybinds.zsh

# Only run on interactive shells
if [[ $- == *i* ]]; then
	bindkey -e
	
	# Control + backspace and Control + delete
	bindkey '^H' backward-kill-word
	bindkey '5~' kill-word
	
	# CTRL + Arrow Left/Right
	bindkey ";5C" forward-word
	bindkey ";5D" backward-word

	# CTRL-R - Paste the selected command from history into the command line
	fzy-history-widget() {
  		local selected num
  		setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  		selected=( $(fc -rl 1 | fzy) )
		local ret=$?
  		if [ -n "$selected" ]; then
    		num=$selected[1]
    		if [ -n "$num" ]; then
      			zle vi-fetch-history -n $num
    			fi
  		fi
		zle reset-prompt
		return $ret
	}

	zle     -N   fzy-history-widget
	bindkey '^R' fzy-history-widget
fi

