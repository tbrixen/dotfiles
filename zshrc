# Load Zinit
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# My plugins (all deferred with wait'0' for faster startup)
zi ice lucid wait'0'; zi light "zsh-users/zsh-syntax-highlighting"
zi ice lucid wait'0'; zi light "zsh-users/zsh-completions"
zi ice lucid wait'0'; zi light "zsh-users/zsh-autosuggestions"
zi ice lucid wait'0'; zi snippet OMZP::git
zi ice lucid wait'0'; zi snippet OMZP::eza

# Load Completions (rebuild cache if older than 24h, otherwise use cache)
autoload -Uz compinit
local old_dumps=(~/.zcompdump(N.mh+24))
if (( $#old_dumps )); then
  compinit
else
  compinit -C
fi

# Update zinit once in a while
RANDOM_NUMBER=$((RANDOM % 100 + 1))
# Check for updates and install them
if [[ $RANDOM_NUMBER -eq 1 ]]; then
  zi self-update
  zi update --parallel
fi

eval "$(starship init zsh)"

LW_PATH=~/lunar
GOPATH=~/go
GOBIN="$GOPATH/bin"
PATH="$GOBIN:$PATH"

# save a lot of history
HISTSIZE=1000000
SAVEHIST=1000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups 

PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"

export EDITOR="nvim"

alias lg="lazygit"

# Lazy-load pyenv (saves ~200ms)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}
# create new venv
#   uv venv myenv
# activate 
#   source myenv/bin/activate
# install package
#   uv pip install the-package

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/tbrixen/.bun/_bun" ] && source "/Users/tbrixen/.bun/_bun"

alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'

# Case-insensitive completion (lowercase matches uppercase and vice versa)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Ctrl+Space to accept autosuggestion
bindkey '^ ' autosuggest-accept

