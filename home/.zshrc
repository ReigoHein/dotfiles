# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hein/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Arrow autocompletion
zstyle ':completion:*' menu select

# Set up oh-my-zsh

ZSH="/usr/share/oh-my-zsh/"
ZSH_THEME="agnoster"

plugins=(
 git
 bundler
 dotenv
 osx
 rake
 rbenv
 ruby
)

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Use nvim
export VISUAL=nvim
export EDITOR=nvim

alias vim="nvim"

# rbenv init
eval "$(rbenv init -)"

# init nvm
source /usr/share/nvm/init-nvm.sh
