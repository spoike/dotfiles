#!/usr/bin/env zsh
# Installs aws-cli
# As described in http://docs.aws.amazon.com/cli/latest/userguide/installing.html

source $HOME/dotfiles/scripts/funcs.sh

pyv=$(python -c 'import platform; print(platform.python_version())' | cut -c 1-3 -)
if [ ! "$pyv" = "2.7" ]; then
  warn "Need python version 2.7.x..."
  exit 1
fi
ok "python $(python -c 'import platform; print(platform.python_version())')"

if [ ! -x "$(command -v pip)" ]; then
  warn "pip is missing, installing..."
  sudo easy_install pip
fi
ok "pip"

if [ ! -x "$(command -v aws)" ]; then
  msg "Installing aws-cli"
  sudo pip install awscli
else
  sudo pip install --upgrade awscli
fi
ok "aws-cli"

if [ ! -d $HOME/.aws ]; then
  msg "aws configuration is missing, running aws configure"
  aws configure
else
  ok "aws configuration"
fi
