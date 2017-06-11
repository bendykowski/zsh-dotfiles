#!/usr/bin/env zsh

# Go to main dotfiles directory
alias dotfiles="cd $DOTFILES"

########## ALIASES #########
alias 'galias?=echo ?:Search aliases using grep'
alias 'fa?=echo ?:Search aliases by fuzzy search'
# Grep aliases
galias() {
    params="$@"
    alias | grep --colour=always "$params"
}
# Fuzzy search aliases
fa() {
  __export_aliases_prettyfied
  print -z $(
    echo $ALIASES_PRETTYFIED | 
    fzf -m | 
    sed 's/\(.*\) \-\>.*/\1/')
}

########## HISTORY ##########
alias 'fh?=echo ?:Search history by fuzzy search'
# fh - Search history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

########## SUDO ##########
# Sudo previous command
alias pls='sudo `fc -n -l -1`'

########## FILES ##########
alias 'fe?=echo ?:Open with the default editor the file selected by fuzzy search'
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

########## DIRECTORIES ##########
alias 'up?=echo ?:cd .. n times'
alias 'fd?=echo ?:cd to directory selected by fuzzy search'
alias 'fda?=echo ?:cd to directory selected by fuzzy search including hidden ones'
alias 'cdf?=echo ?:cd to parent directory of files selected by fuzzy search'
# Go UP n times: ex. 'up 2' means 'cd ../..'
up() {
    if [[ "$#" < 1 ]] ; then
        cd ..
    else
        CDSTR=""
        for i in {1..$1} ; do
            CDSTR="../$CDSTR"
        done
        cd $CDSTR
    fi
}
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

########## PROCESSES ##########
alias 'fkill?=echo ?:Kill process selected by fuzzy search'
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

########## GIT ##########
alias 'fbr?=echo ?:Checkout git branch selected by fuzzy search'
alias 'fco?=echo ?:Checkout git branch/tab selected by fuzzy search'
alias 'fcoc?=echo ?:Checkout git commit selected by fuzzy search'
alias 'fshow?=echo ?:Browse commits using fuzzy search'
alias 'fcs?=echo ?:Get hash of commit selected by fuzzy search'
alias 'fstash?=echo ?:Browse and diff stashes selected by fuzzy search'
alias 'current_branch?=echo ?:Shows the name of the current branch'
alias 'current_repository?=echo ?:Shows the name of the current repository'
alias 'work_in_progress?=echo ?:Checks if the current branch is a WIP'
alias 'gfg?=echo ?:List files in the index or the working tree matching given name'
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(
    echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(
    echo "$branch" | 
    sed "s/.* //" | 
    sed "s#remotes/[^/]*/##")
}
# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | 
    awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | 
    grep -v HEAD |
    sed "s/.* //" | 
    sed "s#remotes/[^/]*/##" |
    sort -u | 
    awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}
# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(
    echo "$commits" | 
    fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(
    echo "$commit" | 
    sed "s/ .*//")
}
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out key sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    out=("${(f)${out}}")
    key="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$key" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$key" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

########## VAGRANT ##########
alias 'vs?=echo ?:List all vagrant boxes with statuses by fuzzy search and try to access the selected one via ssh'
vs() {
  #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
  cd $(
    cat ~/.vagrant.d/data/machine-index/index | 
    jq '.machines[] | {name, vagrantfile_path, state}' | 
    jq '.name + "," + .state  + "," + .vagrantfile_path'| 
    sed 's/^"\(.*\)"$/\1/' | 
    column -s, -t | 
    sort -rk 2 | 
    fzf | 
    awk '{print $3}');
  vagrant ssh
}