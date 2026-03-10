# Detect OS
case "$(uname)" in
  Darwin) IS_MAC=true ;;
  Linux)  IS_LINUX=true ;;
esac

# Load Zinit
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# Update zinit once in a while
RANDOM_NUMBER=$((RANDOM % 100 + 1))
# Check for updates and install them
if [[ $RANDOM_NUMBER -eq 1 ]]; then
  zi self-update
  zi update --parallel
fi

# My plugins (all deferred with wait'0' for faster startup)
zi ice lucid wait'0'; zi light "zsh-users/zsh-syntax-highlighting"
zi ice lucid wait'0'; zi light "zsh-users/zsh-completions"
zi ice lucid wait'0'; zi light "zsh-users/zsh-autosuggestions"
zi ice lucid wait'0'; zi snippet OMZP::git
zi ice lucid wait'0'; zi snippet OMZP::eza

# Mac-specific plugins
if [[ -n "$IS_MAC" ]]; then
  zi ice wait lucid atload:"k8s_init tosb@lunar.app admin"; zi load "lunarway/lw-zsh"
fi

# Load Completions (rebuild cache if older than 24h, otherwise use cache)
autoload -Uz compinit
local old_dumps=(~/.zcompdump(N.mh+24))
if (( $#old_dumps )); then
  compinit
else
  compinit -C
fi

eval "$(starship init zsh)"

LW_PATH=~/lunar
GOPATH=~/go
GOBIN="$GOPATH/bin"
PATH="$GOBIN:$PATH"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"

if [[ -n "$IS_MAC" ]]; then
  export HAMCTL_OAUTH_IDP_URL=https://login.lunar.tech/oauth22eoZqaXcLD417
fi

alias lg="lazygit"
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'

amp() {
  command amp --visibility private "$@"
}
if [[ -n "$IS_MAC" ]]; then
  _load_wiz_creds() {
    if [[ -z "$WIZ_CLIENT_ID" ]]; then
      echo "🔐 Loading MCP credentials from 1Password..."
      export WIZ_CLIENT_ID=$(op read --account=Lunar "op://Private/Wiz MCP/WIZ_CLIENT_ID")
      export WIZ_CLIENT_SECRET=$(op read --account=Lunar "op://Private/Wiz MCP/WIZ_CLIENT_SECRET")
      export WIZ_DATACENTER=$(op read --account=Lunar "op://Private/Wiz MCP/WIZ_DATACENTER")
      echo "✅ MCP credentials loaded."
    fi
  }
  ampwiz() {
    _load_wiz_creds
    command amp --visibility private "$@"
  }
  ampp() {
    _load_wiz_creds
    command amp "$@"
  }
fi

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


export EDITOR="nvim"

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
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Mac-specific environment
if [[ -n "$IS_MAC" ]]; then
  [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
  
  # Added by LM Studio CLI (lms)
  export PATH="$PATH:/Users/tbrixen/.lmstudio/bin"
  # End of LM Studio CLI section

  # PAI (Personal AI Infrastructure) Configuration
  export PAI_DIR="$HOME/.claude"
  export DA="Hal"
  export DA_COLOR="cyan"
  export ENGINEER_NAME="Tobias Stenby Brixen"
fi


# Case-insensitive completion (lowercase matches uppercase and vice versa)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Ctrl+Space to accept autosuggestion
bindkey '^ ' autosuggest-accept

if [[ -n "$IS_MAC" ]]; then
  [[ -f "$HOME/lunar/gravity-tools/scripts/sync-hook.sh" ]] && source "$HOME/lunar/gravity-tools/scripts/sync-hook.sh"
  alias gra-skill-sync='bash "/Users/tbrixen/lunar/gravity-tools/scripts/setup-skills.sh" --sync'
fi

# Machine-local overrides & secrets (not committed)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
