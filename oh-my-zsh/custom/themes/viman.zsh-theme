#!/usr/bin/env zsh

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" | "
ZSH_THEME_GIT_PROMPT_STATUSES_PREFIX=" [ "
ZSH_THEME_GIT_PROMPT_STATUSES_SUFFIX=" ]"
ZSH_THEME_GIT_PROMPT_BRANCH="%Bon%b %F{magenta}"
ZSH_THEME_GIT_PROMPT_STAGED="%F{red}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{red}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%F{blue}%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}%{✔%G%}"

prompt_dir() {
    echo -n "
%Bin%b %F{green}%~%f"
}

prompt_git() {
    echo " $(git_super_status)"
}

prompt_status() {
    [[ $UID -eq 0 ]] && echo -n "%F{red}#%f"
    [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n "%F{cyan}&%f"
}

prompt_arrow() {
    echo -n "%(?.%F{green}.%F{red})=>%f "
}

build_prompt() {
    prompt_dir
    prompt_git
    prompt_status
    prompt_arrow
}

PROMPT='$(build_prompt)'