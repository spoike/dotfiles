#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up packages from github"
downloadBasePrefix=$HOME/Projects/stuff

platform=`uname`
if [[ $platform == 'Linux' ]]; then
  platform='linux-amd64'
elif [[ $platform == 'Darwin' ]]; then
  platform='darwin-amd64'
fi

if [[ ! -x "$(command -v hub)" ]]; then
  warn "github/hub is not installed"
  url=$(curl -s https://api.github.com/repos/github/hub/releases/latest > /dev/null | jq -r ".assets[].browser_download_url | select( contains(\"$platform\") )")
  file=`basename $url .tgz`
  echo "Downloading $url -> $downloadBasePrefix/$file"
  mkdir -p $downloadBasePrefix
  (cd $downloadBasePrefix && curl -sL "$url" > /dev/null | tar xz)
  echo "Copying $file to bin"
  cp $downloadBasePrefix/$file/bin/hub $HOME/bin
  echo "Removing downloaded file"
  rm -rf $downloadBasePrefix/$file
  ok "github/hub"
else
  ok "github/hub"
fi
