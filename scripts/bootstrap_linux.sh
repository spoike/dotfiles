#!/usr/bin/env zsh

if [[ -f /etc/debian_version ]]; then
  packages=()
  if ! [ -x "$(command -v git)" ]; then
    packages+=(git)
  fi
  if [ $packages ]; then
    sudo apt-get install $packages
  fi
fi
