# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${ZDOTDIR:-$HOME}/.zshrc"

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
zstyle ':completion:*:*' ignored-patterns '*?~'

GNUBIN="\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/opt/gnu-indent/libexec/gnubin:\
/usr/local/opt/gnu-tar/libexec/gnubin:\
/usr/local/opt/ed/libexec/gnubin:\
/usr/local/opt/grep/libexec/gnubin:\
/usr/local/opt/gnu-sed/libexec/gnubin:\
/usr/local/opt/gawk/libexec/gnubin:\
/usr/local/opt/gnu-time/libexec/gnubin:\
/usr/local/opt/findutils/libexec/gnubin:\
/usr/local/opt/gnu-which/libexec/gnubin"
export PATH="$HOME/bin:$HOME/script:$GNUBIN:$PATH"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Custom alias
alias zgit='cat ~/.zprezto/modules/git/alias.zsh | grep "alias " | grep'
alias joblist='ssh ims-command joblist'

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
_fzf_compgen_path() {
    echo "$1"
    command find -L "$1" \
        -name .git -prune -o -name .svn -prune -o -name '*~' -prune -o \( -type d -o -type f -o -type l \) \
        -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
}
_fzf_compgen_dir() {
    command find -L "$1" \
        -name .git -prune -o -name .svn -prune -o -name '*~' -prune -o -type d \
        -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
}

# Added by Krypton
export GPG_TTY=$(tty)

# Volt
export VOLTPATH="$HOME/.volt"

# Go
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

autoload -Uz bashcompinit
bashcompinit
if [[ -s $GOPATH/src/github.com/vim-volt/volt/_contrib/completion/bash ]]; then
    source $GOPATH/src/github.com/vim-volt/volt/_contrib/completion/bash
fi

# z
. /usr/local/etc/profile.d/z.sh

# sshmount
if [[ -s "$HOME/.sshmnt.sh" ]]; then
    source "$HOME/.sshmnt.sh"
fi
