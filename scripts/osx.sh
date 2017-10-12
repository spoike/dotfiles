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

  # Install Homebrew http://brew.sh/
  if [ ! -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
	  ok "brew (Homebrew)"
  fi

  # Install Cask https://caskroom.github.io/
  if ! brew info cask &>/dev/null; then
    brew tap caskroom/cask
  else
    ok "brew cask"
  fi

  list=$(brew tap)
  missing=()
  for t in "${(@f)"$(<./scripts/brew.taps)"}"; do
    [[ ! $list == *$t* ]] && missing+=$t || ok "brew tap:  $t"
  done
  if [[ ! -z $missing ]]; then
    warn "Missing taps: ${missing}. Will now attempt to add them to brew."
    for t in $missing; do
      brew tap $t
    done
  fi

  list=$(brew list)
  missing=()
  for c in "${(@f)"$(<./scripts/brew.packages)"}"; do
    [[ ! $list == *$c* ]] && missing+=$c || ok "brew pkg:  $c"
  done
  if [[ ! -z $missing ]]; then
    warn "Missing brew packages: ${missing}. Will now attempt to install with brew."
    brew cask install $missing
  fi

  list=$(brew cask list)
  missing=()
  for c in "${(@f)"$(<./scripts/cask.packages)"}"; do
    [[ ! $list == *$c* ]] && missing+=$c || ok "brew cask: $c"
  done
  if [[ ! -z $missing ]]; then
    warn "Missing casks: ${missing}. Will now attempt to install with brew cask."
    brew cask install $missing
  fi

fi

stuff=$HOME/Projects/stuff

if [[ ! -d $stuff/iTerm2-Color-Schemes ]]; then
  msg "Missing Term2 Color Schemes will attempt to clone and build..."
  git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git $stuff/iTerm2-Color-Schemes
else
  ok "iTerm2-Color-Schemes"
fi

if [[ ! -d $stuff/seoul256-iTerm ]]; then
  msg "Missing seoul256-iTerm will attempt to clone and build..."
  git clone https://github.com/mikker/seoul256-iTerm.git $stuff/seoul256-iTerm
else
  ok "seoul256-iTerm"
fi

CODEFONT="Fura Code Retina Nerd Font Complete Mono.otf"
if [[ ! -f ~/Library/Fonts/$CODEFONT ]]; then
  msg "Missing \"$CODEFONT\", attempt to download and install"
  pushd ~/Library/Fonts
  curl -fLo "Fura Code Retina Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete%20Mono.otf 
  popd
else
  ok "Font: \"$CODEFONT\""
fi
