#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up global npm packages"

packages=()
[ ! -x "$(command -v git-fire)" ] && packages+=(git-fire) || ok git-fire
if [ ! -z "$packages" ]; then
  warn "Missing packages: ${packages}. Will now attempt to install with npm."
  npm install -g $packages
else
  ok "npm packages"
fi
