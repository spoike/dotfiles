#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

if [[ -f /etc/debian_version ]]; then
  msg "Setting up Linux Debian/Ubuntu"

  packages=()
  [ ! -x "$(command -v git)" ] && packages+=(git) || ok git
  [ ! -x "$(command -v tig)" ] && packages+=(tig) || ok tig
  [ ! -x "$(command -v jq)" ] && packages+=(jq) || ok jq
  [ ! -x "$(command -v wget)" ] && packages+=(wget) || ok wget
  [ ! -x "$(command -v tmux)" ] && packages+=(tmux) || ok tmux
  if [ ! -z "$packages" ]; then
    warn "Missing packages: ${packages}. Will now attempt to install with apt-get."
    sudo apt-get install $packages
  else
    ok "apt-get packages"
  fi
fi
