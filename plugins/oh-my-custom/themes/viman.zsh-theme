#!/usr/bin/env zsh

source $DOTFILES/plugins/zsh-git-prompt/zshrc.sh

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" | "
ZSH_THEME_GIT_PROMPT_STATUSES_PREFIX=" [ "
ZSH_THEME_GIT_PROMPT_STATUSES_SUFFIX=" ]"
ZSH_THEME_GIT_PROMPT_BRANCH="%Bon%b %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"

PROMPT='
%Bin%b %{$fg[green]%}%~%{${reset_color}%} $(git_super_status)
%B%#%b '