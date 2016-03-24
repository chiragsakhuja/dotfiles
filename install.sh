#!/bin/bash

rm -rf ~/.tmux*
rm -rf ~/.vim*
rm ~/.tmux.conf
rm ~/.tmux.colors
rm ~/.vimrc

ln -s .tmux.conf ~/.tmux.conf
ln -s .tmux.colors ~/.tmux.colors
ln -s .vimrc ~/.vimrc
mkdir ~/.vim
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe.vim
cd ~/.vim/bundle/YouCompleteMe.vim
git submodule --init --recursive
./install.sh --clang-completer
sed -i '/compat/d' third_party/ycmd/cpp/ycm
cd -

vim -S "install_commands.ex"
