#!/usr/bin/env zsh

export PATH=$PATH:$DOTFILES/plugins/zsh-git-prompt/src/.bin

# Editors
export EDITOR="nvim"

# History
export HISTFILE=$DOTFILES/.zsh_history
setopt hist_ignore_all_dups

# Git
export GIT_PROMPT_EXECUTABLE="haskell"