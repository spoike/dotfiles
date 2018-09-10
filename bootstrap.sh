#!/usr/bin/env zsh
#
# Bootstrap script to link dotfiles and necessary packages.
# Tested on Ubuntu and OS X
#
# Please run this from the same directory as the script

setopt extendedglob

zparseopts -- a=promptall

source ./scripts/funcs.sh

dir=$(dirname -- "$0:A")
cd $dir                            # Making sure we're in the script's directory
backupDir="${dir}_old"             # Backup directory for old dotfiles

# Ensure the backup directory is in place for old dotfiles
mkdir -pv ${backupDir}

msg "Setting up dotfiles"
./bootstrap_castle.sh

# Ensure .zshrc_extras file is created
if [ ! -f $HOME/.zshrc_extras ]; then
  warn ".zshrc_extras is missing... Creating empty file"
  touch $HOME/.zshrc_extras
else
  ok ".zshrc_extras"
fi

if [ ! -f $HOME/.local.gitconfig ]; then
  warn ".local.gitconfig is missing... Creating empty file"
  touch $HOME/.local.gitconfig
else
  ok ".local.gitconfig"
fi
#
# Install platform dependent packages and settings
platform=`uname`
if [[ $platform == 'Linux' ]]; then
  ./scripts/linux.sh
elif [[ $platform == 'Darwin' ]]; then
  ./scripts/osx.sh
fi

# Install platform independent packages and settings
./scripts/common.sh

# Install github packages
./scripts/github_releases.sh

if [[ -x "$(command -v npm)" ]]; then
  ./scripts/npm.sh
else
  warn "Missing npm, cannot install global npm packages"
fi

# Install with prompt
if [[ ! -z $promptall ]]; then
  read -q "REPLY?Install atom packages? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    ./scripts/atom/atom.sh
  fi

  read -q "REPLY?Install aws-cli? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    ./scripts/aws/aws.sh
  fi

  read -q "REPLY?Install VsCode settings? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    ./bootstrap_code.sh
  fi
fi
