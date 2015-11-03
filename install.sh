#!/usr/bin/env bash
# Bootstrap script to link dotfiles and necessary packages.
# Tested on Ubuntu and OS X
#
# Dependencies: zsh
#
# Please run this from the same directory as the script

platform=`uname`
if [[ $platform == 'Linux' ]]; then
  if [[ -f /etc/debian_version ]]; then
    if ! [ -x "$(command -v zsh)" ]; then
      echo "zsh is missing, installing..."
      sudo apt-get install zsh
      sudo chsh -s $(which zsh)
    fi
  fi
fi
./bootstrap.sh

# If chsh doesn't work (due to Kerberos setup) you need to add the following to
# the .bashrc file to start up the terminal with tmux:
#
# # TMUX
# if [[ -z "$TMUX" ]] ;then
#   ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#   if [[ -z "$ID" ]] ;then # if not available create a new one
#     tmux new-session
#   else
#     tmux attach-session -t "$ID" # if available attach to it
#   fi
# fi
#
# See more at https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
