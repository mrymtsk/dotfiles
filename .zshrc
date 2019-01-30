# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/Toshiki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
zstyle ':completion:*:*files' ignored-patterns '*?~'

export PATH="$HOME/bin:$HOME/script:$HOME/go/bin:/usr/local/opt/unzip/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/unzip/share/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

autoload -Uz bashcompinit
bashcompinit
if [[ -s $HOME/go/src/github.com/vim-volt/volt/_contrib/completion/bash ]]; then
    source $HOME/go/src/github.com/vim-volt/volt/_contrib/completion/bash
fi

# Custom alias
alias zgit='cat ~/.zprezto/modules/git/alias.zsh | grep "alias " | grep'
alias jobinfo='ssh ims-command jobinfo -h cclx -l -w -c'

# Locale environmental variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# hub alias
eval "$(hub alias -s)"

autoload -Uz colors
colors

setopt globdots

# chpwd
chpwd() {
  if [ $(($(tput lines) - 5)) -gt $(ls -A1 | wc -l) ]; then
    ls -ABFlhs
  else
    ls -ABCF
  fi
}

# GitHub Token
source $HOME/.github_token

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="set -o pipefail; command find -L . -mindepth 1 \( -name '*~' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) -prune -o -type f -print -o -type l -print 2> /dev/null | cut -b3-"
export FZF_CTRL_T_COMMAND="command find -L . -mindepth 1 \( -name '*~' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) -prune -o -type f -print -o -type d -print -o -type l -print 2> /dev/null | cut -b3-"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \( -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \) -prune -o -type d -print 2> /dev/null | cut -b3-"

# Added by Krypton
export GPG_TTY=$(tty)

# Volt
export VOLTPATH="/Users/Toshiki/.volt"

# Go
export GOPATH="/Users/Toshiki/.go"
