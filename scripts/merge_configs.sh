#!/usr/bin/env zsh

pushd mergeable
for file in $(ls .*)
do
  echo $file
  if [ ! -z "$(diff $HOME/$file $file)" ]; then
    vimdiff $HOME/$file $file
  fi
done
popd

