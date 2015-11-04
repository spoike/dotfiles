#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up OSX"

l=$(xcode-select -p)
if [ ! $? -eq 0 ]; then
  xcode-select --install
else
  ok "Command line tools"
fi
