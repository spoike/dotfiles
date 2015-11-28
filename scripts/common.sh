#!/usr/bin/env zsh
# Is run from ../bootstrap.sh

source ./scripts/funcs.sh

msg "Setting up platform independent packages"

# Install antigen for zsh
if [ ! -d $HOME/.antigen ]; then
  mkdir -p $HOME/.antigen
  curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > $HOME/.antigen/antigen.zsh && ok antigen
else
  ok antigen
fi

# Install Vundle for vim
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
  msg "Installing Vundle for vim"
  mkdir -p $HOME/.vim/bundle
  # Install Vundle and all plugins
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall && ok Vundle
else
  #vim +PluginUpdate +qall
  ok Vundle
fi

# Install Node Version Manager
if [[ ! -s $HOME/.nvm/nvm.sh ]]; then
  msg "Missing nvm, installing..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash && ok nvm
else
  ok nvm
fi

stuff=$HOME/Projects/stuff
current=`pwd`
mkdir -p $stuff

if [[ ! -d $stuff/nyancat ]]; then
  msg "Missing nyancat will attempt to clone and build..."
  git clone https://github.com/klange/nyancat.git $stuff/nyancat
  cd $stuff/nyancat/src/
  make
  cd $current
else
  ok "nyancat"
fi

if [[ ! -d $stuff/nyan-dopefish ]]; then
  msg "Missing dopefish will attempt to clone and build..."
  git clone https://github.com/spoike/nyan-dopefish.git $stuff/nyan-dopefish
  cd $stuff/nyan-dopefish/src/
  make
  cd $current
else
  ok "dopefish"
fi

if [[ ! -d $stuff/powerline-fonts ]]; then
  msg "Missing powerline fonts. Will attempt to clone and install..."
  git clone https://github.com/powerline/fonts.git $stuff/powerline-fonts
  cd $stuff/powerline-fonts
  ./install.sh
  cd $current
else
  ok "powerline fonts"
fi
