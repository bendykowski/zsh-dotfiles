#!/usr/bin/env zsh

export DOTFILES=$HOME/.new-zsh

source $DOTFILES/exports.zsh

# Load all custom files
for file in $DOTFILES/custom/*.zsh; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
done;
unset file;

source $DOTFILES/ohmyzshrc.zsh