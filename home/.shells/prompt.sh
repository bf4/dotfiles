#!/usr/bin/env sh
source "$HOME/${DOTFILES_HOME}/.shells/colors.sh"

__my_rvm_prompt() {
  eval ~/.rvm/bin/rvm-prompt
}

# TODO: remove [[ ]] bashism
# Set git autocompletion and PS1 integration for showing git info in terminal
# https://github.com/iambowen/dotfiles/blob/master/bash_profile
# https://gist.github.com/ryknow/3303462/raw/2e2f9dd271f3caa83a435965664e59f0dd4626dc/.bashrc
# https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh

GIT_PS1_SHOWDIRTYSTAT=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
build_git_prompt(){
  find_git_status
  if [ -n $git_status ]; then
    find_git_dirty
    find_git_branch
    local git_status_color
    case "$git_status" in
      ahead_nothing_to_commit)
      git_status_color=$bldylw
      ;;
      nothing_to_commit)
      git_status_color=$txtcyn
      ;;
      untracked_files_nothing_to_commit)
      git_status_color=$txtred:$bakwht
      ;;
      tracked_changes)
      git_status_color=$txtylw
      ;;
      *)
      git_status_color=$txtylw
      ;;
    esac
    git_prompt="${txtcyn}${git_status_color}${git_branch}${txtred}${git_dirty}${txtrst}"
  else
    git_prompt=""
  fi
}

find_git_branch() {
  local branch
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

find_git_status() {
  git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      if [[ "$git_status" =~ Your\ branch\ is\ ahead ]]; then
        git_status="ahead_nothing_to_commit"
      else
        git_status="nothing_to_commit"
      fi
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      git_status="untracked_files_nothing_to_commit"
    else
      git_status="tracked_changes"
    fi
  else
    git_status="" # not a repo
  fi
}

find_git_dirty() {
  if [[ $(git status --porcelain 2> /dev/null) != "" ]]; then
    git_dirty='!'
  else
    git_dirty=''
  fi
}


if ! $(echo $PROMPT_COMMAND | grep -q build_git_prompt); then
  PROMPT_COMMAND="build_git_prompt; $PROMPT_COMMAND"
fi

# Default Git enabled prompt with dirty state
export PS1="\$(__my_rvm_prompt)\$git_prompt\w\n📝 $ "

# Default Git enabled root prompt (for use with "sudo -s")
# doesn't require txtuid
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
