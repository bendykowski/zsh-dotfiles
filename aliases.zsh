#!/usr/bin/env zsh

# Go to main dotfiles directory
alias dotfiles="cd $DOTFILES"

# Find alias
falias() {
    params="$@"
    alias | grep "$params"
}

# Go UP n times: ex. 'up 2' means 'cd ../..'
up() {
    if [[ "$#" < 1 ]] ; then
        cd ..
    else
        CDSTR=""
        for i in {1..$1} ; do
            CDSTR="../$CDSTR"
        done
        cd $CDSTR
    fi
}