#!/usr/bin/env zsh
source ./scripts/funcs.sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
	ok "Up-to-date"
	exit 0
elif [ $LOCAL = $BASE ]; then
	msg "Upstream has updated. Will rebase with latest and run install script."
	pause
	git rebase origin master
	./install.sh
elif [ $REMOTE = $BASE ]; then
	warn "Need to push. Will attempt to do so..."
	pause
	git push
	exit 0
else
	warn "Diverged. You will need to solve the merge conflict if such exists."
	info "Here is git status for you:"
	git status
	exit 1
fi

OLD_VIMRC=$(git rev-parse HEAD:castle/.vimrc)
OLD_GITCONFIG=$(git rev-parse HEAD:mergeable/.gitconfig)

NEW_VIMRC=$(git rev-parse "$UPSTREAM":castle/.vimrc)
NEW_GITCONFIG=$(git rev-parse "$UPSTREAM":mergeable/.gitconfig)

if [[ $OLD_VIMRC!=$NEW_VIMRC ]]; then
	msg ".vimrc has updated. Will install plugins in vim."
	pause
	vim +PlugInstall +qall
fi
vim +PlugUpgrade +PlugUpdate +qall
if [[ $OLD_GITCONFIG!=$NEW_GITCONFIG ]]; then
	msg ".gitconfig has updated. Prepare to merge."
	pause
	make merge
fi
