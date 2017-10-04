#!/usr/bin/env zsh
source ./scripts/funcs.sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
	ok "dotfiles repository is up-to-date"
elif [ $LOCAL = $BASE ]; then
	msg "Upstream has updated. Will rebase with latest and run install script."
	pause
	git rebase origin master
	./install.sh
	source $HOME/.zshrc
elif [ $REMOTE = $BASE ]; then
	warn "Need to push. Will attempt to do so..."
	pause
	git push
else
	warn "Local has diverged from remote. You will need to solve the merge conflicts with $UPSTREAM if such exists."
	info "Here is git status for you:"
	git status
	exit 1
fi

OLD_VIMRC=$(git rev-parse HEAD:castle/.vimrc)

NEW_VIMRC=$(git rev-parse "$UPSTREAM":castle/.vimrc)

if [[ $OLD_VIMRC != $NEW_VIMRC ]]; then
	msg ".vimrc has updated. Will install plugins in vim."
	pause
	vim +PlugUpgrade +PlugUpdate +PlugInstall +qall
else
	read -q REPLY\?"Would you like to update vim plugins? (y/N) "
	case "${REPLY}" in
		y|Y)
			vim +PlugUpgrade +PlugUpdate +qall
	esac
	echo ""
fi

platform=`uname`
if [[ $platform == 'Darwin' ]]; then
	read -q REPLY\?"Would you like to update brew? (y/N) "
	echo ""
	case "${REPLY}" in
		y|Y)
		brew -v update; brew upgrade --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor
	esac
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	read -q REPLY\?"Would you like to update zprezto? (y/N) "
	echo ""
	case "${REPLY}" in
		y|Y)
		(source ~/.zprezto/init.zsh && zprezto-update)
	esac
	read -q REPLY\?"Would you like to update zprezto plugins? (y/N) "
	echo ""
	case "${REPLY}" in
		y|Y)
		pushd ~/.zprezto
		git submodule update --init --recursive
		popd
	esac
fi
