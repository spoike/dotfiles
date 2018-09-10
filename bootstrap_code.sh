#!/usr/bin/env zsh
#
# Symlinks settings for Visual Studio Code so it may be synced

setopt extended_glob

dotfiles_dir=$(cd "$( dirname "$0" )" && pwd)

source ./scripts/funcs.sh

platform=`uname`
if [[ ! $platform == 'Darwin' ]]; then
  warn "Code settings only works for Mac for now"
  exit 0
fi

code_settings_path="$HOME/Library/Application Support/Code/User"
code_dotfiles_dir="$dotfiles_dir/code"

dotfiles=("${(@f)$(cd $code_dotfiles_dir; printf '%s\n' **/*~*swp(D:^M))}")

for file in $dotfiles; do
  shortFile="...Code/User/$file"
  src="$code_dotfiles_dir/$file"
  dest="$code_settings_path/$file"
  # if directory doesn't exist create it
  if [ -d $src ]; then
    mkdir -p $dest
    continue
  fi
  if [ -L $dest ]; then
    ok $shortFile
    continue
  fi
  if [ -f $dest ]; then
    warn "$dest exists, please merge/move settings to $src and remove the former to proceed"
    echo "A diff between files will open."
    pause
    diff $src $dest | less
    exit 1
  fi
  echo "Symlinking $dest"
  ln -vs $src $dest
  ok $shortFile
done
