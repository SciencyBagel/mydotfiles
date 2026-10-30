# Shared environment needed while Oh My Zsh loads plugins and custom files.
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/mydotfiles/home/.oh-my-zsh/custom"
export MYDOTFILES_PATH="$HOME/mydotfiles" # Used while custom/functions.zsh loads.

# Host-specific environment (such as Homebrew) must load before Oh My Zsh.
_host_early="$ZSH_CUSTOM/hosts/early/${HOST%%.*}.zsh"
[[ -r "$_host_early" ]] && source "$_host_early"
unset _host_early

# Paths shared by all hosts.
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.local/share/npm-packages/bin:$HOME/.npm-global/bin"

# Oh My Zsh initializes completion, so add personal completion directories first.
fpath+=("$HOME/.zfunc")

# Plugin and tool settings read during Oh My Zsh startup.
export KEYTIMEOUT=1 # 10ms for vi-mode
export VI_MODE_SET_CURSOR=true
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT='-c'
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS="
--style full \
--preview \
\"fzf-preview.sh {}\" \
--bind 'focus:transform-header:file \
--brief {}' \
 --popup 80%"


# =========================================================================
# Oh My Zsh loads plugins, then top-level custom/*.zsh files and the theme.
ZSH_THEME="bira"
zstyle ':omz:update' mode disabled
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting vi-mode)
source "$ZSH/oh-my-zsh.sh"
# =========================================================================


# Personal interactive setup that can use Oh My Zsh completion and plugins.
if command -v nvim &>/dev/null; then
  export EDITOR='nvim'
elif command -v vim &>/dev/null; then
  export EDITOR='vim'
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif command -v fzf &>/dev/null && fzf --zsh &>/dev/null; then
  eval "$(fzf --zsh)"
else
  echo "Warning: fzf not found"
fi

# Per-host setup runs last; Oh My Zsh only auto-loads top-level custom/*.zsh.
_host_config="${ZSH_CUSTOM:-$ZSH/custom}/hosts/${HOST%%.*}.zsh"
[[ -r "$_host_config" ]] && source "$_host_config"
unset _host_config
