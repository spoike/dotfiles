if [[ -z "$TMUX" ]] ;then
  ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
  if [[ -z "$ID" ]] ;then # if not available create a new one
    tmux new-session
  else
    tmux attach-session -t "$ID" # if available attach to it
  fi
fi

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
