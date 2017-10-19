#!/bin/bash

# Must be run from within this directory

safeDelete() {
	if [ -z "$1" ]; then
		return 1
	fi

	if [ -e "$1" ]; then
		if [ -f "$1" -o -d "$1" ]; then
			rm -rf "$1"
		else
			unlink "$1"
		fi
	fi

	return 0
}

ZSHROOT=$(which zsh)
ZSHFOUND=$?
if [ $ZSHFOUND -eq 0 ]; then
    safeDelete ~/.zshrc
    safeDelete ~/.oh-my-zsh

    if [[ "$SHELL" != "$ZSHROOT" ]]; then
        chsh -s $ZSHROOT -u $USER
    fi

    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

    safeDelete ~/.zshrc   # need to do this again because installer creates a zshrc
    ln -s $PWD/.zshrc ~/.zshrc

    mkdir -p ~/.oh-my-zsh/custom/themes/
    ln -s $PWD/simple.zsh-theme ~/.oh-my-zsh/custom/themes/
fi

safeDelete ~/.vim
safeDelete ~/.vimrc
safeDelete ~/.tmux.conf
safeDelete ~/.tmux.colors

ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.tmux.colors ~/.tmux.colors
ln -s $PWD/.vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
