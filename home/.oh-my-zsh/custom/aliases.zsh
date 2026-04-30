alias less='less -R'

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

alias t='tmux'

alias cd-z='cd $ZSH/custom/'

# find file and open it with default editor
alias fzfo='fzf --print0 | xargs -0 -o $EDITOR'
