#!/bin/bash

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

REMOTE=$(git config --get remote.origin.url)
if [[ ! $REMOTE =~ chiragsakhuja/dotfiles ]]; then
    echo "$0 should be run from within its directory"
    exit 1
fi

ZSHROOT=$(which zsh)
ZSHFOUND=$?
if [[ $ZSHFOUND == 0 ]]; then
    safeMove ~/.zshrc
    safeMove ~/.oh-my-zsh

    mkdir -p ~/.cache/zcompdump

    if [[ "$SHELL" != "$ZSHROOT" ]]; then
        chsh -s $ZSHROOT
    fi

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    rm ~/.zshrc   # need to do this again because installer creates a zshrc
    ln -s $PWD/.zshrc ~/.zshrc
    ln -s $PWD/.zshrc.local ~/.zshrc.local

    mkdir -p ~/.oh-my-zsh/custom/themes/
    ln -s $PWD/simple.zsh-theme ~/.oh-my-zsh/custom/themes/

    git clone https://github.com/popstas/zsh-command-time.git ~/.oh-my-zsh/custom/plugins/command-time
    chmod g-w,o-w ~/.oh-my-zsh/custom/plugins/command-time
fi

safeMove ~/.vim
safeMove ~/.vimrc
safeMove ~/.tmux.conf
safeMove ~/.tmux.conf.local

ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.tmux.conf.local ~/.tmux.conf.local
ln -s $PWD/.vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

git config --global alias.plog "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
