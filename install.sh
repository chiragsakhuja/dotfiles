#!/bin/bash

rm -rf ~/.tmux*
rm -rf ~/.vim*
rm ~/.tmux.conf
rm ~/.tmux.colors
rm ~/.vimrc

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux.colors ~/.tmux.colors
ln -s ~/dotfiles/.vimrc ~/.vimrc
mkdir ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -S "install_commands.ex"
