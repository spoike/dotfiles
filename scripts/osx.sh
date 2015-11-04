#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up OSX"

# XCode Command-line Tools
l=$(xcode-select -p)
if [ ! $? -eq 0 ]; then
  xcode-select --install
else
  ok "XCode Command-line Tools"
fi

if [ ! -x "$(command -v brew)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ok "Homebrew (brew)"
fi
