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

packages=()
[ ! -x "$(command -v git)" ] && packages+=(git)
[ ! -x "$(command -v tig)" ] && packages+=(tig)
[ ! -x "$(command -v jq)" ] && packages+=(jq)
[ ! -x "$(command -v wget)" ] && packages+=(wget)
[ ! -x "$(command -v tmux)" ] && packages+=(tmux)
if [ $packages ]; then
  brew update
  brew install $packages
fi
