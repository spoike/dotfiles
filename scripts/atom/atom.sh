#!/usr/bin/env zsh

selfpath=$(dirname -- $0:A)
source $HOME/dotfiles/scripts/funcs.sh

installed=`apm ls -ib`
packages=()
list=(`cat ${selfpath}/atom.packages`)
for package in $list; do
  if [[ ! -n "${installed[(r)${package}]}" ]]; then
    warn "$package"
    packages+="$package"
  else
    ok "$package"
  fi
done

if [[ ! -z $packages ]]; then
  msg "Will install missing Atom packages..."
  for package in $packages; do
    apm install ${package}
  done
else
  msg "All atom packages are installed"
fi
