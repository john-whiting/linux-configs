# Track Execution Time
function time_preexec() {
  cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}

function time_precmd() {
  if [ $cmd_start ]; then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $cmd_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if   ((h > 0)); then cmd_time=${h}h${m}m
    elif ((m > 0)); then cmd_time=${m}m${s}s
    elif ((s > 9)); then cmd_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then cmd_time=${s}.$(printf %03d $ms)s # 1.234s
    else cmd_time=${ms}ms
    fi

    unset cmd_start
  else
    # Clear previous result when hitting Return with no command to execute
    unset cmd_time
  fi
}

function last_exec_time() {
  if [ $cmd_time ]; then
    echo "${cmd_time} ";
  else
	echo ""
  fi
}

add-zsh-hook preexec time_preexec
add-zsh-hook precmd time_precmd

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add color spectrum print
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Arma virumque cano Troiae qui primus ab oris%f"
  done
}

