# Host config for ms-7d32 (CUDA workstation).
# Sourced by .zshrc only when $HOST matches this filename.

# CUDA toolkit
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# nvm — this host manages node itself rather than via the system package
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# add llama.cpp bin to path
LLAMA_BIN_PATH=/opt/llama.cpp/build/bin
if [[ -d "$LLAMA_BIN_PATH" ]]; then
  export PATH="$PATH:$LLAMA_BIN_PATH"
else
  echo "Warning: $LLAMA_BIN_PATH was not found."
fi
