#!/usr/bin/env zsh

# Set $DOTFILES path
export DOTFILES=$HOME/.zsh

# Load main exports
source $DOTFILES/exports.zsh

# Load all custom files
for file in $DOTFILES/custom/*.zsh; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
done;
unset file;

# Load oh-my-zsh config and framework itself
source $DOTFILES/ohmyzshrc.zsh