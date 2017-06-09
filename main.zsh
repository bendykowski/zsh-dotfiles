#!/usr/bin/env zsh

. $HOME/.zsh/exports.zsh

# Load all custom files
for file in $HOME/.zsh/custom/*.zsh; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && . "$file";
done;
unset file;