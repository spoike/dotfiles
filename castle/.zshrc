#!/bin/zsh
#
# .zshrc - ZSH file loaded on interactive shell sessions
#

source /usr/local/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Source Prezto.
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi

# Autocompletions
# Read about them here: https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
## Add .zsh-functions to fpath
ZFUNCDIR=${ZFUNCDIR:-$HOME/.zsh-functions}
fpath=($ZFUNCDIR $fpath)

## Projects w. autocomplete
pd(){cd $HOME/Projects/$1;}
compctl -W $HOME/Projects -/ pd

# Reverse history search with Ctrl-R
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

## Quick reload of completion script
reload_cmpl(){unfunction $1 && autoload -U $1;}

[ -e "${HOME}/.zshrc_profile" ] && source "${HOME}/.zshrc_profile"
[ -e "${HOME}/.zshrc_aliases" ] && source "${HOME}/.zshrc_aliases"
[ -e "${HOME}/.zshrc_extras" ] && source "${HOME}/.zshrc_extras"
[ -e "${HOME}/.zstyles" ] && source "${HOME}/.zstyles"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

