#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up OSX"

# Defaults
# Use all F1, F2, ...etc keys as standard function keys (FnLock)
defaults write NSGlobalDomain com.apple.keyboard.fnState -int 1

# XCode Command-line Tools
if [ ! -x "$(command -v xcode-select)" ]; then
  warn "Please install XCode Command-line Tools in order to install homebrew and its packages."
else
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
  [ ! -d "/usr/local/opt/coreutils/libexec" ] && packages+=(coreutils) || ok coreutils
  [ ! -x "$(command -v git)" ] && packages+=(git) || ok git
  [ ! -x "$(command -v tig)" ] && packages+=(tig) || ok tig
  [ ! -x "$(command -v jq)" ] && packages+=(jq) || ok jq
  [ ! -x "$(command -v wget)" ] && packages+=(wget) || ok wget
  [ ! -x "$(command -v tmux)" ] && packages+=(tmux) || ok tmux
  [ ! -x "$(command -v task)" ] && packages+=(task) || ok task
  [ ! -x "$(command -v reattach-to-user-namespace)" ] && packages+=(reattach-to-user-namespace) || ok reattach-to-user-namespace
  if [ $packages ]; then
    warn "Missing packages: ${packages}. Will now attempt to install with brew."
    brew update
    brew install $packages
  fi
fi

stuff=$HOME/Projects/stuff

if [[ ! -d $stuff/iTerm2-Color-Schemes ]]; then
  msg "Missing Term2 Color Schemes will attempt to clone and build..."
  git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git $stuff/iTerm2-Color-Schemes
else
  ok "iTerm2-Color-Schemes"
fi
