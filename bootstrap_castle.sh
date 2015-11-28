#!/usr/bin/env zsh
#
# Symlinks files recursively from castle directory to
# your home directory. Will also ensure that directories
# in castle is created at home directory.

setopt extended_glob

dotfiles_dir=$(cd "$( dirname "$0" )" && pwd)

source ./scripts/funcs.sh

castle=$dotfiles_dir/castle
dotfiles=("${(@f)$(cd $castle; printf '%s\n' **/*~*swp(D:^M))}")
backup=$HOME/dotfiles_backup

for file in $dotfiles; do
  if [ -d $castle/$file ]; then
    mkdir -p $HOME/$file
    mkdir -p $backup/$file
    continue
  fi
  if [ -L $HOME/$file ]; then
    if [ "$HOME/$file" -ef "$castle/$file" ]; then
      ok $file
      continue
    fi
    warn "$HOME/$file does not point to $castle/$file. Removing it."
    rm $HOME/$file
  fi
  if [ -f $HOME/$file ]; then
    echo "Backing up $HOME/$file"
    mv -v $HOME/$file $backup/$file
  fi
  echo "Symlinking $HOME/$file"
  ln -vs $castle/$file $HOME/$file
  ok $file
done
