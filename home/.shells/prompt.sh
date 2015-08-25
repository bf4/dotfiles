#!/usr/bin/env sh
. "$HOME/${DOTFILES_HOME}/.shells/colors.sh"

__my_rvm_prompt() {
  [ -f ~/.rvm/bin/rvm-prompt ] && eval ~/.rvm/bin/rvm-prompt
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
  if [ -n "$git_status" ]; then
    find_git_branch
    local git_status_color
    local prompt_status
    git_dirty_details=""
    for each_status in $git_status; do
      # echo "Trying '${each_status}'"
      case "$each_status" in
        ahead)
        git_status_color=$bldylw
        ;;
        tracked_changes)
        git_status_color=$txtcyn
        git_dirty_details="${git_dirty_details}${txtblu}*${txtrst}"
        ;;
        staged_changes)
        git_status_color=$txtcyn
        git_dirty_details="${git_dirty_details}${txtcyn}+${txtrst}"
        ;;
        untracked_files)
        git_dirty_details="${git_dirty_details}_"
        ;;
        clean)
        git_status_color=""
        ;;
        *)
        echo "prompt.sh doesn't know what '${each_status}' is"
        git_status_color=$txtred:$bakwht
        ;;
      esac
    done
    git_prompt="${git_status_color}(${git_branch}${txtred}${git_dirty}${txtrst})${git_dirty_details}"
  else
    git_prompt=""
  fi
}

find_git_branch() {
  local branch
  # if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
  #   branch=${BASH_REMATCH[1]}
  # else
  #   # branch="($(git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD))"
  # fi
  # Based on: http://stackoverflow.com/a/13003854/170413
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [ "$branch" = "HEAD" ]; then
      branch='detached*'
    fi
    git_branch="$branch"
  else
    git_branch=""
  fi
}

find_git_status() {
  git_status="" # not a repo
  git_dirty="" # default isn't dirty
  local current_status
  current_status="$(git status -unormal 2>&1)"
  # http://stackoverflow.com/a/19897118/879854
  case "$current_status" in
    *Not\ a\ git\ repo*) current_status="not_repo";;
  esac
  if [ "$current_status" != "not_repo" ]; then
    case "$current_status" in
      *Your\ branch\ is\ ahead*)                     git_status="ahead";;
      *Changes\ not\ staged*)                        git_status="$git_status tracked_changes"; git_dirty="!";;
      *Changes\ to\ be\ committed*)                  git_status="$git_status staged_changes";  git_dirty="!";;
      *ntracked\ files*)                             git_status="$git_status untracked_files";;
      *working\ directory\ clean*)                   git_status="$git_status clean";;
      *nothing\ to\ commit*)                         git_status="$git_status clean";;
    esac
  fi
}

# eval "__orig__$(declare -f build_git_prompt)" &&
#  build_git_prompt() {
#   (
#     git() {
#       timeout 3 /usr/bin/git "$@";
#     }
#   timeout 3 __orig__build_git_prompt "$@"
#   )
# }
timeout_build_git_prompt() {
  build_git_prompt
  # timeout -t 10 build_git_prompt
}

if ! $(echo $PROMPT_COMMAND | grep -q timeout_build_git_prompt); then
  PROMPT_COMMAND="timeout_build_git_prompt; $PROMPT_COMMAND"
fi
