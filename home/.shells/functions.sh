#!/usr/bin/env sh
brewup() {
    brew update &&
    brew cleanup &&
    brew cask cleanup
}

ttmux () {
  local t=$(which tmux)
  local cmd=""
  # IF tmux is running && there's a shared session
  if $(ps cax | grep -q tmux) && [ -e /tmp/shared ]; then
    # THEN attach
    cmd="$t -S /tmp/shared attach -t shared"
  else
    # ELSE rm shared session file, if present
    # AND new
    rm -f /tmp/shareds
    cmd="$t -S /tmp/shared new -s shared"
    chgrp brew /tmp/shared
  fi
  eval "$cmd"
  echo $cmd
}

# https://youtu.be/8ZMOWypU34k?t=807
# This command is credit Ben Orenstein. The command scans your bash history and generates a list of your most frequently used 1-2 word commands. The items high on this list are often good candidates for aliasing.
# The top n commands in the history file
topcmds() {
  [ ! -z $1 ] && n="$1" || n="10"
  history | awk '{a[$2 " " $3]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -n $n
}

# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
# cd to the path of the front Finder window
# with some modifications
# and references to https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/osx/osx.plugin.zsh
# and https://github.com/jbtule/cdto
cdf() {
  target=`osascript -e \
    'tell application "Finder" \
      to \
      if (count of Finder windows) > 0 then \
        get POSIX path of (target of front Finder window as text)
    ' 2>/dev/null`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found or is search results' >&2
  fi
}
# open finder window in current dir
alias f='open -a Finder ./'

# ls -lS | head +10 # find largest files
# ls -lSr | tail -10 # find smallest files
findgt() {
  sizeinkb="$1"
  find . -type f -size "+${sizeinkb}k" -print0 | xargs -0 du -sh
  # find . -type f -size +50000k -exec ls -lh {} \; | awk '{ print $9 ": " $5
}
# http://www.cyberciti.biz/faq/find-large-files-linux/
findsize() {
   du -xak .|sort -n|tail -50
   # print out stars and the length of the stars show the usage of each folder / file from smallest to largest on the box:
   # du -k | sort -n | perl -ne 'if ( /^(\d+)\s+(.*$)/){$l=log($1+.1);$m=int($l/log(1024)); printf  ("%6.1f\t%s\t%25s  %s\n",($1/(2**(10*$m))),(("K","M","G","T","P")[$m]),"*"x (1.5*$l),$2);}'
}

gitreset() {
  local branch_name="$(cat .git/HEAD | cut -d/ -f3,4,5,6)"
  # local branch_name="$(git name-rev --name-only HEAD)"
  local remote_name="$(git config branch.${branch_name}.remote)"
  remote_name="${remote_name:-origin}"
  local ref="${remote_name}/${branch_name}"
  echo "Fetching and resetting ${ref}"
  git remote prune "$remote_name"
  git fetch "$remote_name"
  git reset --hard "${ref}"
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

# http://stackoverflow.com/a/1371215
fetch_remotes() {
  local pwd=$(pwd)
  find . -depth 1 -type d | while read dir ; do
    cd $(echo "$dir" | sed 's/ /\\ /')
    echo "$(pwd)"
    if [ -f ".git/config" ]; then
      git remote update
    else
      echo "not a git remote"
    fi
    cd "$pwd"
  done
}


# Bash script to keep a git clone synced with a remote
# Use the following under a process manager (such as runit)
# to keep a local git clone in sync with a remote,
# when a push based solution isn’t an option.
# Most other versions either neglect to verify remote is correct,
# or use git pull which can fail if someone has been monkeying with the local version.
# http://rhnh.net/2014/04/26/bash-script-to-keep-a-git-clone-synced-with-a-remote
#
#   update_git_repo "/tmp/myrepo" "git://example.com/my/repo.git"
#
#   sleep 60 # No need for a tight loop
function update_git_repo() {
  GIT_DIR=$1
  GIT_REMOTE=$2
  GIT_BRANCH=${3:-master}

  if [ ! -d $GIT_DIR ]; then
    CURRENT_SHA=""
    git clone --depth 1 $GIT_REMOTE $GIT_DIR -b $GIT_BRANCH
  else
    CURRENT_REMOTE=$(cd $GIT_DIR && git config --get remote.origin.url || true)

    if [ "$GIT_REMOTE" == "$CURRENT_REMOTE" ]; then
      CURRENT_SHA=$(cat $GIT_DIR/.git/refs/heads/$GIT_BRANCH)
    else
      rm -Rf $GIT_DIR
      exit 0 # Process manager should restart this script
    fi
  fi

  cd $GIT_DIR && \
    git fetch && \
    git reset --hard origin/$GIT_BRANCH

  NEW_SHA=$(cat $GIT_DIR/.git/refs/heads/$GIT_BRANCH)
}


# pull_branch joaomdmoura active_model_serializers deserializer-implementation
# pull_branch() {
#   local handle="$1"
#   local lib="$2"
#   local branch="$3"
#   git pull "https://github.com/${handle}/${lib}.git" "${branch}"
# }

# pull_branch joaomdmoura:deserializer-implementation
# pull_branch() {
#   local args="$*"
#   ruby -e "
#   handle, branch = '${args}'.strip.split(':');
#   lib = File.basename(Dir.pwd);
#   %x(git pull https://github.com/#{handle}/#{lib}.git #{branch})
#   "
# }
git_co_pr() {
 local pr_number="$1"
 git fetch -q origin "+refs/pull/${pr_number}/head"
 git checkout -qf FETCH_HEAD
}

validate_yaml() {
 local filename="$1"
 ruby -ryaml -e "puts YAML.load_file('${filename}')"
}


# http://solidfoundationwebdev.com/blog/posts/create-an-bash-function-to-open-latest-active-record-migration
last_migration(){
  vim db/migrate/$(ls db/migrate/ | sort | tail -1)
}

# pgr() {
#   for x in rails phantomjs zeus; do
#     pgrep -fl $x;
#   done
# }
#
# pgk() {
#   for x in rails phantomjs zeus; do
#     pkill -fl $x;
#   done
# }
