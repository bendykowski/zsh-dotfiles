#!/usr/bin/env zsh

export path=(
    /usr/local/sbin
    $path
    $DOTFILES/plugins/zsh-git-prompt/src/.bin
)

# Editors
export EDITOR="nvim"

# History
export HISTFILE=$DOTFILES/.zsh_history
setopt hist_ignore_all_dups

# Git
export GIT_PROMPT_EXECUTABLE="haskell"

# Alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="ALIAS TIP: "

# Command time
ZSH_COMMAND_TIME_MIN_SECONDS=3
ZSH_COMMAND_TIME_ECHO=1