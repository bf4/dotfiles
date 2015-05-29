#!/usr/bin/env sh
source ~/.shells/colors.sh
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

alias ber='bundle exec rake'
alias bes='bundle exec rspec -fs'
alias bec='bundle exec cucumber -r features'
alias bsc='bundle exec rails s'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'

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
# parse_git_branch() {
#   cat .git/HEAD | sed -e 's/^.*refs\/heads\///'
#   # git branch --no-color 2> /dev/null | sed -e '/^[^\*]/d' -e 's/^\*\ \(.*\)/(\1) /'
# }
# gitpullr() {
#   git pull --rebase origin $(git branch | grep '*' | cut -d' ' -f2)
# }
git_last_tag() {
  git for-each-ref --sort='*authordate' --format='%(tag)' refs/tags | egrep "^${branch}\.[0-9]+$" | tail -n1
}

__my_rvm_prompt() {
  eval ~/.rvm/bin/rvm-prompt
}

# Set git autocompletion and PS1 integration for showing git info in terminal
# https://github.com/iambowen/dotfiles/blob/master/bash_profile
# https://gist.github.com/ryknow/3303462/raw/2e2f9dd271f3caa83a435965664e59f0dd4626dc/.bashrc
# https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh

build_git_prompt(){
  find_git_status
}

find_git_branch() {
  GIT_PS1_SHOWDIRTYSTAT=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true

  local branch
  local git_status
  git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      # no commits but stuff hasn't been pushed
      if [[ "$git_status" =~ Your\ branch\ is\ ahead ]]; then
        git_status_color=$bldylw
      else
        git_status_color=$txtcyn
      fi
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      git_status_color=$txtylw:$bakwht
    else
      git_status_color=$txtylw
    fi
    true
  else
    false
  fi
  # if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
  #   branch=${BASH_REMATCH[1]}
  # else
  #   # branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
  # fi
  # Based on: http://stackoverflow.com/a/13003854/170413
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  if [ -n $git_status_color ]; then
    # git diff --quiet head &>/dev/null
    local status=$(git status --porcelain 2> /dev/null)
    if [[ "$status" != "" ]]; then
      git_dirty='!'
    else
      git_dirty=''
    fi
  else
    git_dirty=''
  fi
}


PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
export PS1="\$(__my_rvm_prompt)\[$txtcyn\]\[$git_status_color\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\w\n📝 $ "

# Default Git enabled root prompt (for use with "sudo -s")
# doesn't require txtuid
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
