# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="simple"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-time)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Pretty colors
export TERM="xterm-256color"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Use vim keybindings in the shell
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        (vicmd)      VIMODE="N" ;;
        (main|viins) VIMODE="I" ;;
        (*)          VIMODE="I" ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Enable pushd and popd across all terminals
ZPDIRS=$HOME/.zpdirs
pushpd() {
    if [[ ! $# == 0 ]]; then
        return 1
    fi

    echo $PWD >> $ZPDIRS
}
poppd() {
    if [[ ( ! $# == 0 ) || ( ! -f $ZPDIRS ) ]]; then
        return 1
    fi

    NEXTPWD=$(tail -n1 $ZPDIRS)

    if [[ $NEXTPWD == "" ]]; then
        return 2
    fi

    head -n-1 $ZPDIRS > $ZPDIRS.tmp
    mv $ZPDIRS.tmp $ZPDIRS
    lcd $NEXTPWD
}

# Get to directories to jump to easily
GODIRS=$HOME/.godirs
get() {
    if [[ ! $# == 1 ]]; then
        return 1
    fi

    if [[ ! -f $GODIRS ]]; then
        return 0
    fi

    SEARCH=$(grep "$1[^,]*," $GODIRS)
    RES=$?
    if [[ $RES == 0 ]]; then
        DIR=$(echo $SEARCH | cut -d',' -f2 | head -n 1)
        echo $DIR
    else
        return 2
    fi
}
go() {
    if [[ ! $# == 1 ]]; then
        return 1
    fi

    DIR=$(get $1)
    RES=$?
    if [[ $RES == 0 ]]; then
        lcd $DIR
    else
        return $RES
    fi
}

abspath() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (\cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(\cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}

lcd() {
    if [[ $# < 1 ]]; then
        return 1
    fi

    cd $@ && ls .
}
mcd() {
    if [[ ! $# == 1 ]]; then
        return 1
    fi

    mkdir $1 && lcd $1
}
pcd() {
    if [[ ! $# == 1 ]]; then
        return 1
    fi

    lcd ${PWD%/$1/*}/$1
}

append_env() {
    if [[ $# != 2 ]]; then
        return 1
    fi

    CURVAL="${(P)1}"
    if [[ -z "$CURVAL" ]]; then
        export $1="$2"
    else
        export $1="$CURVAL:$2"
    fi
}

alias f='find . -name'
alias cd='lcd'

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
    alias vimf='vim $(fzf)'
fi

# add changes in local branch below here
