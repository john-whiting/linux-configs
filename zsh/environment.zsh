# Add poetry to PATH
export PATH=~/.local/share/pypoetry/venv/bin/:${PATH}

# Add nvim to PATH
NVIM_PATH=~/.nvim
if [ -d "$NVIM_PATH" ]
then
  export PATH=~/.nvim/bin:${PATH}
  export NVIM_PATH
fi
