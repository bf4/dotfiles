#!/usr/bin/env sh
# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
# cd to the path of the front Finder window
# with some modifications
# and references to https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/osx/osx.plugin.zsh
# and https://github.com/jbtule/cdto
brewup() {
    brew update &&
    brew upgrade brew-cask &&
    brew cleanup &&
    brew cask cleanup
}

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
  local branch_name="$(git name-rev --name-only HEAD)"
  local remote_name="$(git config branch.${branch_name}.remote)"
  remote_name="${remote_name:-origin}"
  local ref="${remote_name}/${branch_name}"
  echo "Fetching and resetting ${ref}"
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
    cd $(echo "$pwd" | sed 's/ /\\ /')
  done
}

# pull_branch joaomdmoura active_model_serializers deserializer-implementation
# pull_branch() {
#   local handle="$1"
#   local lib="$2"
#   local branch="$3"
#   git pull "https://github.com/${handle}/${lib}.git" "${branch}"
# }

# pull_branch joaomdmoura:deserializer-implementation
pull_branch() {
  local args="$*"
  ruby -e "
  handle, branch = '${args}'.strip.split(':');
  lib = File.basename(Dir.pwd);
  %x(git pull https://github.com/#{handle}/#{lib}.git #{branch})
  "
}

validate_yaml() {
 local filename="$1"
 ruby -ryaml -e "puts YAML.load_file('${filename}')"
}
