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
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer
sed -i.bak '/compat/d' ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py
cd -

vim -S "install_commands.ex"
