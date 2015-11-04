#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

if [[ -f /etc/debian_version ]]; then
  msg "Setting up Linux Debian/Ubuntu"

  packages=()
  [ ! -x "$(command -v git)" ] && packages+=(git)
  [ ! -x "$(command -v tig)" ] && packages+=(tig)
  if [ $packages ]; then
    sudo apt-get install $packages
  fi
fi
