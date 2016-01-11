#!/usr/bin/env zsh
#
# Bootstrap script to link dotfiles and necessary packages.
# Tested on Ubuntu and OS X
#
# Please run this from the same directory as the script

setopt extendedglob

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

msg "Setting up config files (merging)"
# Merge config files
mergeFiles() {
  cd mergeable
  files=`ls .*~*swp`
  for file in $files; do
    if [[ -e $backupDir/$file && -e $HOME/$file ]]; then
      ok $file
      continue
    fi
    if [ -f $HOME/$file ]; then
      msg "Backing up and merging $file"
      cp -v $HOME/$file $backupDir
      merged=$(diff3 -m $HOME/$file $dir/mergeable/$file $dir/mergeable/$file)
      if [ ! $? -eq 0 ]; then
        # merge conflict, edit, and save it in place
        printf %s "$merged" | EDITOR=vim pipeEditor > $HOME/$file
      else
        printf %s "$merged" > $HOME/$file
      fi
    else
      msg "Adding $file"
      cp -v $dir/mergeable/$file $HOME/$file
    fi
    ok $file
  done
}
( mergeFiles )

# Install platform dependent packages and settings
platform=`uname`
if [[ $platform == 'Linux' ]]; then
  ./scripts/linux.sh
elif [[ $platform == 'Darwin' ]]; then
  ./scripts/osx.sh
fi

# Install platform independent packages and settings
./scripts/common.sh

if [[ -x "$(command -v npm)" ]]; then
  ./scripts/npm.sh
else
  warn "Missing npm, cannot install global npm packages"
fi

