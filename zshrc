# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zcustom"

#ZSH_THEME="ys"

# Hyphen-insensitive completion. _ and - will be interchangeable.
# Case-sensitive completion must be off.  
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  osx
  ant
  docker
  docker-machine
  docker-compose
  nmap
  rsync
  sudo
  tmux
  ansible
)

plugins=(you-should-use $plugins)


source $ZSH/oh-my-zsh.sh

# User configuration
fpath=("$HOME/.zfunctions" $fpath)
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
prompt pure


function options() {
    PLUGIN_PATH="$HOME/.oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}

