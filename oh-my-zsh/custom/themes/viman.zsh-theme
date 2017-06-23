#!/usr/bin/env zsh

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

prompt_dir() {
    echo -n "
%Bin%b %{$fg[green]%}%~%{${reset_color}%}"
}

prompt_git() {
    echo " $(git_super_status)"
}

prompt_status() {
    [[ $UID -eq 0 ]] && echo -n "%{$fg[red]%}#%{${reset_color}%}"
    [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n "%{$fg[cyan]%}&%{${reset_color}%}"
}

prompt_arrow() {
    echo -n "%(?.${fg[green]}.${fg[red]})=>%{${reset_color}%} "
}

build_prompt() {
    prompt_dir
    prompt_git
    prompt_status
    prompt_arrow
}

PROMPT='$(build_prompt)'