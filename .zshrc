[ -e "${HOME}/.zshrc_aliases" ] && source "${HOME}/.zshrc_aliases"
[ -e "${HOME}/.zshrc_profile" ] && source "${HOME}/.zshrc_profile"

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
  #taskwarrior

  sdurrheimer/docker-compose-zsh-completion
  yonchu/grunt-zsh-completion
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  #kennethreitz/autoenv
EOBUNDLES

antigen theme agnoster
antigen apply
