alias less='less -R'
alias bath='bat -p -l help'

# If you're using GNU grep via Homebrew, this is fine.
alias grep='grep --color=auto'
alias egrep='grep -E'

# Check if ls supports GNU-specific flags before setting the alias
if ls --color=always /dev/null &>/dev/null 2>&1; then
    alias ls='ls --color=always -h --group-directories-first'
fi

alias ll='ls -l'

alias reload='exec zsh'

alias py=python
alias tm='tmux'

alias cd-omz='cd $ZSH/custom/'
alias cd-nvim='cd $HOME/.config/nvim'

# paginate command help like `command --help | bath`
alias bath='bat -l help -p'

# find file and open it with default editor
alias fzfo='fzf --print0 | xargs -0 -o $EDITOR'

alias print-timestamp='date +"%Y-%m-%d_%H:%M:%S"'

# work
alias cd-odin='cd $HOME/Workshop/gitlab-workbench/odin/'
