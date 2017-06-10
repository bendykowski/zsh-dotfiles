#!/usr/bin/env zsh

# Set $DOTFILES path
export DOTFILES=$HOME/.zsh

# Load main exports
source $DOTFILES/exports.zsh

# Load main aliases
source $DOTFILES/aliases.zsh

# Load all custom files
for file in $DOTFILES/custom/*.zsh; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
done;
unset file;

# Load FuzzyFinder if exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load oh-my-zsh config and framework itself
source $DOTFILES/ohmyzshrc.zsh

# Welcome screen
source $DOTFILES/welcome.zsh