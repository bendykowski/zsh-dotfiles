#!/usr/bin/env zsh

# Go to main dotfiles directory
alias dotfiles="cd $DOTFILES"

# Find alias
find-alias() {
    params="$@"
    alias | grep --colour=always "$params"
}
alias '?alias=find-alias'

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

# Search history (??) and processes (???)
alias '?=fc -li 1'
alias '??=fc -li 1 | grep '
alias '???=pgrep'