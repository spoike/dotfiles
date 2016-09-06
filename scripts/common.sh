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

# Install vim-plug
## Remove old Vundle install
if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
  rm -rf $HOME/.vim/bundle
fi
if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
  msg "Installing vim-plug"
  ## Install vim-plug and all specified plugins
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall +qall && ok "vim-plug"
else
  ok "vim-plug"
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

if [[ ! -d $HOME/.tmuxifier ]]; then
  msg "Missing tmuxifier. Will attempt to clone..."
  git clone https://github.com/jimeh/tmuxifier.git $HOME/.tmuxifier
elif [[ ! -d $HOME/.tmuxifier/bin ]]; then
  msg "Missing tmuxifier but directory exists. Attempt to init git..."
  pushd $HOME/.tmuxifier
  git init
  git remote add origin https://github.com/jimeh/tmuxifier.git
  git fetch
  git checkout -t origin/master
  popd
else
  ok "tmuxifier"
fi

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  msg "Missing tmux plugin manager. Will attempt to clone..."
  mkdir -p $HOME/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
else
  ok "tmux plugin manager"
fi
