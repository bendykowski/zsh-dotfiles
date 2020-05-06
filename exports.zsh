#!/usr/bin/env zsh

export path=(
    /usr/local/opt/llvm/bin
    /usr/local/sbin
    ${HOME}/go/bin
    $path
    $DOTFILES/plugins/zsh-git-prompt/src/.bin
)

# Editors
export EDITOR="nvim"
export VISUAL="nvim"

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

# Detect used OS
OS=$(detect_os)

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
