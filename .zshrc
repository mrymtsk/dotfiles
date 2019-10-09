MAILCHECK=0

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
export PATH="${ZDOTDIR:-$HOME}/opt/bin:${ZDOTDIR:-$HOME}/script:$GNUBIN:$PATH"
export LD_LIBRARY_PATH="${ZDOTDIR:-$HOME}/opt/lib:$LD_LIBRARY_PATH"
export XDG_CONFIG_HOME="${ZDOTDIR:-$HOME}/.config"

source_if_exists() {
    local file_path
    for source_file in "$@"
    do
        if [[ ${source_file:0:1} = "/" ]]; then
            file_path=$source_file
        else
            file_path=${ZDOTDIR:-$HOME}/$source_file
        fi
        if [[ -s $file_path ]]; then
            source "$file_path"
            break
        fi
    done
}

# TMUX
tmuxconf="${ZDOTDIR:-$HOME}/.tmux.conf"
tmuxsocket="mrymtsk"
if [[ -z $TMUX ]]; then
    if hostname | grep -q 'ccfep[2-8]'; then
        ssh ccfep1.ims.ac.jp -o RequestTTY=force env COLORTERM="$COLORTERM" ZDOTDIR="${ZDOTDIR:-$HOME}" zsh
        exit 0
    fi
    if [[ -z $(tmux -L $tmuxsocket list-sessions) ]]; then
        tmux -f "$tmuxconf" -L $tmuxsocket new-session
    else
        tmux -f "$tmuxconf" -L $tmuxsocket attach
    fi
    exit 0
fi

# Lines configured by zsh-newuser-install
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
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

# Source Prezto.
source_if_exists .zprezto/init.zsh

# Customize to your needs...

# Custom alias
alias zgit='cat ~/.zprezto/modules/git/alias.zsh | grep "alias " | grep'
alias vim='vim -u ${ZDOTDIR:-$HOME}/.vim/vimrc'

# Locale environmental variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# hub alias
if type hub >/dev/null 2>&1; then
    eval "$(hub alias -s)"
fi

autoload -Uz colors
colors

setopt globdots

# chpwd
chpwd() {
  if [ $(($(tput lines) - 5)) -gt "$(find . -maxdepth 1 -not -name . -not -name '*~' | wc -l)" ]; then
    ls -ABFlhs
  else
    ls -ABCF
  fi
}

# GitHub Token
source_if_exists .github_token

# dircolors
if [[ -r ${ZDOTDIR:-$HOME}/.dir_colors ]]; then
    eval "$(dircolors "${ZDOTDIR:-$HOME}/.dir_colors")"
fi

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

# Go
export GOPATH="${ZDOTDIR:-$HOME}/.go"

# Volt
export VOLTPATH="${ZDOTDIR:-$HOME}/.volt"
export VOLT_VIM_DIR="${ZDOTDIR:-$HOME}/.vim"

# z
export _Z_DATA="${ZDOTDIR:-$HOME}/.z"
source_if_exists script/z.sh /usr/local/etc/profile.d/z.sh

# sshmount
source_if_exists .sshmnt.sh

# Docker
source_if_exists script/docker_wrapper.sh

typeset -U path PATH
