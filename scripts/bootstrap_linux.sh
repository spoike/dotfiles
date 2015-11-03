#!/usr/bin/env zsh

if [[ -f /etc/debian_version ]]; then
  packages=()
  [ ! -x "$(command -v git)" ] && packages+=(git)
  [ ! -x "$(command -v tig)" ] && packages+=(tig)
  if [ $packages ]; then
    sudo apt-get install $packages
  fi
fi
