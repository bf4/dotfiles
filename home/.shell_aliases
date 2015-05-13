#!/usr/bin/env sh
# alias ls='ls --color=auto'
# Like less but outputs colors instead of raw ansi escape codes
# brew install source-highlight
# export LESSOPEN="| `brew --prefix`/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export LESSCHARSET=utf-8 # don't print out unicode as e.g. <E2><80><99>
# alias vless='vim -u /usr/share/vim/vim71/macros/less.vim'
# https://superuser.com/questions/71588/how-to-syntax-highlight-via-less
# function cless () {
#     pygmentize -f terminal "$1" | less -R
# }
# alias vless="/Applications/MacVim.app/Contents/Resources/vim/runtime/macros/less.sh"

[ -s '/usr/local/bin/hub' ] && eval "$(hub alias -s)" || echo "no hub"

alias gitdiffgraph="git log --pretty=format:'%h %s' --graph"
alias ber='bundle exec rake'
alias bes='bundle exec rspec -fs'
alias bec='bundle exec cucumber -r features'
alias bsc='bundle exec rails s'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'
alias gitwork="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short --author=benjamin --all"

# alias tmux="TERM=screen-256color-bce tmux"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
#
# use macvim binary if present (it has ruby compiled)
# alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
# [[ -s "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && . alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
gitreset() {
  git fetch origin
  git reset --hard origin/$(git branch | grep '*' | cut -d' ' -f2)
}
parse_git_branch() {
  cat .git/HEAD | sed -e 's/^.*refs\/heads\///'
  # git branch --no-color 2> /dev/null | sed -e '/^[^\*]/d' -e 's/^\*\ \(.*\)/(\1) /'
}
gitpullr() {
  git pull --rebase origin $(git branch | grep '*' | cut -d' ' -f2)
}
git_last_tag() {
  git for-each-ref --sort='*authordate' --format='%(tag)' refs/tags | egrep "^${branch}\.[0-9]+$" | tail -n1
}

__my_rvm_prompt() {
  eval ~/.rvm/bin/rvm-prompt
}
__my_git_prompt() {
  _prompt_colors
  GIT_PS1_SHOWDIRTYSTAT=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      # no commits but stuff hasn't been pushed
      if [[ "$git_status" =~ Your\ branch\ is\ ahead ]]; then
        local ansi=$EMR
      else
        local ansi=$C
      fi
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=$Y:$BGW
    else
      local ansi=$Y
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
    else
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
    fi
    echo -n "$ansi($branch`__git_dirty`)$NONE"
  fi
}

__git_dirty() {
  git diff --quiet head &>/dev/null
  [ $? == 1 ] && echo "!"
}

_prompt_colors() {
  local NONE="\[\033[0m\]"    # unsets color to term's fg color

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local EMK="\[\033[1;30m\]"
  local EMR="\[\033[1;31m\]"
  local EMG="\[\033[1;32m\]"
  local EMY="\[\033[1;33m\]"
  local EMB="\[\033[1;34m\]"
  local EMM="\[\033[1;35m\]"
  local EMC="\[\033[1;36m\]"
  local EMW="\[\033[1;37m\]"

  # background colors
  local BGK="\[\033[40m\]"
  local BGR="\[\033[41m\]"
  local BGG="\[\033[42m\]"
  local BGY="\[\033[43m\]"
  local BGB="\[\033[44m\]"
  local BGM="\[\033[45m\]"
  local BGC="\[\033[46m\]"
  local BGW="\[\033[47m\]"

  local UC=$W                 # user's color
  [ $UID -eq "0" ] && UC=$R   # root's color
}

ensure_update_terminal_cwd() {
  # echo -ne "\033]0;${PWD##/*/}\007"
  type update_terminal_cwd 2>&1 | grep -q 'shell function'
  if [ $? -ne 0 ]
  then
    local SEARCH=' ';
    local REPLACE='%20';
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}";
    printf '\e]7;%s\a' "$PWD_URL"
  else
    update_terminal_cwd;
  fi
}
