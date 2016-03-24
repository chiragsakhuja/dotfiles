#!/bin/bash

rm -rf .tmux*
rm -rf .vim*

ln -s .tmux.conf ~/.tmux.conf
ln -s .tmux.colors ~/.tmux.colors
ln -s .vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle
cd ~/.vim/bundle/YouCompleteMe
git submodule --init --recursive
./install.sh --clang-completer
sed -i '/compat/d' third_party/ycmd/cpp/ycm
cd -

vim -S "install_commands.ex"
