#!/usr/bin/env zsh

git fetch
OLD_HEAD=$(git rev-parse HEAD)
OLD_VIMRC=$(git rev-parse HEAD:castle/.vimrc)
OLD_GITCONFIG=$(git rev-parse HEAD:mergeable/.gitconfig)

NEW_HEAD=$(git rev-parse origin/master)
NEW_VIMRC=$(git rev-parse origin/master:castle/.vimrc)
NEW_GITCONFIG=$(git rev-parse origin/master:mergeable/.gitconfig)

if [[ $OLD_HEAD!=$NEW_HEAD ]]; then
	git rebase origin master
	./install.sh
fi
if [[ $OLD_VIMRC!=$NEW_VIMRC ]]; then
	vim +PlugInstall +qall
fi
if [[ $OLD_GITCONFIG!=$NEW_GITCONFIG ]]; then
	make merge
fi
vim +PlugUpdate +qall

