source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  adb
  aws
  bower
  cp
  docker
  git
  git-flow
  heroku
  sudo
  wd
  web-search
  zsh_reload
  tmux
  tmuxinator
  colorize
  rand-quote
  taskwarrior

  sdurrheimer/docker-compose-zsh-completion
  yonchu/grunt-zsh-completion
  zsh-users/zsh-history-substring-search
  #kennethreitz/autoenv
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

#antigen theme agnoster
BULLETTRAIN_RUBY_SHOW=false
BULLETTRAIN_NVM_SHOW=true
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_CONTEXT_SHOW=false
#BULLETTRAIN_CUSTOM_MSG=""
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Projects w. autocomplete
pd(){cd $HOME/Projects/$1;}
compctl -W $HOME/Projects -/ pd

[ -e "${HOME}/.zshrc_aliases" ] && source "${HOME}/.zshrc_aliases"
[ -e "${HOME}/.zshrc_profile" ] && source "${HOME}/.zshrc_profile"
[ -e "${HOME}/.zshrc_extras" ] && source "${HOME}/.zshrc_extras"
