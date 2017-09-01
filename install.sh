#!/bin/bash

safeMove() {
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

safeMove ~/.vim
safeMove ~/.vimrc
safeMove ~/.tmux.conf
safeMove ~/.tmux.colors

ln -rs ./.tmux.conf ~/.tmux.conf
ln -rs ./.tmux.colors ~/.tmux.colors
ln -rs ./.vimrc ~/.vimrc

mkdir ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
