# Allow local customizations in the ~/.bashrc_local_before file
if [ -f ~/.bashrc_local_before ]; then
    source ~/.bashrc_local_before
fi

# Make it possbile for do Ctrl-s for forward search
# https://superuser.com/questions/159106/reverse-i-search-in-bash
stty -ixon

alias g='git'
alias gs='git status'
alias gss='git status -s'
alias gc='git commit'
alias gco='git checkout'
alias gbr='git branch'
alias ga='git add'
alias glgoaad='git log --graph --oneline --abbrev-commit --all --decorate'
alias d='docker'
alias dc='docker-compose'
alias grep='grep --color'

# Allow local customizations in the ~/.bashrc_local_after file
if [ -f ~/.bashrc_local_after ]; then
    source ~/.bashrc_local_after
fi
