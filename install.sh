#!/bin/bash

# Must be run from within this directory

safeMove() {
    NEWEXT=""
    if [[ $# -eq 1 ]]; then
        NEWEXT="old"
    elif [[ $# -eq 2 ]]; then
        NEWEXT="$2"
    else
        return 1
    fi

    if [[ -e "$1" ]]; then
        NEWNAME="$1.$NEWEXT"
        while [[ -e "$NEWNAME" ]]; do
            NEWNAME="$NEWNAME.$NEWEXT"
        done

        if [[ -L "$1" ]]; then
            LINKPATH=$(readlink "$1")
            echo "Relinking $1 to $NEWNAME"
            unlink "$1"
            ln -s "$LINKPATH" "$NEWNAME"
        else
            echo "Moving $1 to $NEWNAME"
            mv "$1" "$NEWNAME"
        fi
    fi

    return 0
}

ZSHROOT=$(which zsh)
ZSHFOUND=$?
if [[ $ZSHFOUND == 0 ]]; then
    safeMove ~/.zshrc
    safeMove ~/.oh-my-zsh

    exit 0

    if [[ "$SHELL" != "$ZSHROOT" ]]; then
        chsh -s $ZSHROOT -u $USER
    fi

    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

    safeMove ~/.zshrc   # need to do this again because installer creates a zshrc
    ln -s $PWD/.zshrc ~/.zshrc

    mkdir -p ~/.oh-my-zsh/custom/themes/
    ln -s $PWD/simple.zsh-theme ~/.oh-my-zsh/custom/themes/
fi

safeMove ~/.vim
safeMove ~/.vimrc
safeMove ~/.tmux.conf
safeMove ~/.tmux.colors

ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.tmux.colors ~/.tmux.colors
ln -s $PWD/.vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
