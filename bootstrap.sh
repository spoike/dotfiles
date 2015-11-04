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
files=(`ls .*~*swp~.git*`)    # Lists all dotfiles

# Ensure the backup directory is in place for old dotfiles
mkdir -pv ${backupDir}

msg "Setting up dotfiles"
# Backing up and symlinking
for file in $files; do
  if [ -L $HOME/$file ]; then
    ok $file
    continue
  fi
  if [ -f $HOME/$file ]; then
    echo "Backing up and symlinking $file"
    mv -v $HOME/$file $backupDir && ln -vs $dir/$file $HOME/$file
  else
    echo "Symlinking $file"
    ln -vs $dir/$file $HOME/$file
  fi
  ok $file
done

msg "Setting up ~/bin scripts"
linkBinFiles() {
  cd bin
  files=`ls *~*swp`
  src=$dir/bin
  dest=$HOME/bin && mkdir -p $dest
  backupDest=$backupDir/bin && mkdir -p $backupDest
  for file in $files; do
    if [ -L $dest/$file ]; then
      ok bin/$file
      continue
    fi
    if [ -f $dest/$file ]; then
      echo "Backing up and symlinking $file"
      mv -v $dest/$file $backupDest && ln -vs $src/$file $dest/$file
    else
      echo "Symlinking $file"
      ln -vs $dest/$file $src/$file
    fi
    ok bin/$file
  done
}
( linkBinFiles )

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

./scripts/common.sh
