export MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
export MOD_PATH=/usr/local/zend/mysql/bin:$MOD_PATH
export MOD_PATH=$HOME/.cabal/bin:$MOD_PATH
export PATH=$MOD_PATH:$PATH

# source "`brew --prefix grc`/etc/grc.bashrc"
# brew install grc
source ~/.git-completion.sh
#set rvm_trust_rvmrcs_flag=1

export NODE_PATH="/usr/local/lib/node"
export PATH=$PATH:/usr/local/share/npm/bin
#alias ls='ls --color=auto'
#PS1="\e[32;40m\u@\w\[\e[0m\]\n[\h \W$(__git_ps1 " (%s)")]\$> "
function __git_dirty {
  git diff --quiet HEAD &>/dev/null
  [ $? == 1 ] && echo "!"
}

function __git_branch {
  __git_ps1 " %s"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^\*]/d' -e 's/^\*\ \(.*\)/(\1) /'
}


function __my_rvm_ruby_version {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
  local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
  [ "$version" == "1.8.7" ] && version=""
  local full="$version$gemset"
  [ "$full" != "" ] && echo "$full "
}

bash_prompt() {
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

  PS1='\[\e[36m\]$(parse_git_branch)$(__git_dirty)\[\e[0m\]\w\$ '
  # PS1="$B\$(__my_rvm_ruby_version)$Y\h$W:$EMY\w$EMW\$(__git_branch)$EMY\$(__git_dirty)${NONE} $ "
  # PS1="$B\$(__my_rvm_ruby_version)$Y\h$W:$EMY\w$EMW\$EMY\${NONE} $ "
}
bash_prompt
PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"
# PS1='[\W$(__git_ps1 " (%s)")]\$ '
# source "$rvm_path/contrib/ps1_functions"

#ps1_set
function wgets()
{
  wget --referer="http://www.google.com" --user-agent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6" \
  --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" \
  --header="Accept-Language: en-us,en;q=0.5" \
  --header="Accept-Encoding: gzip,deflate" \
  --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" \
  --header="Keep-Alive: 300" "$@"
}
# export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
# export rvm_pretty_print_flag=1
alias gitdiffgraph="git log --pretty=format:'%h %s' --graph"

fortune
# use vi mode in terminal
set -o vi
alias ber='bundle exec rake'
alias bes='bundle exec spec -fs'
alias bec='bundle exec cucumber -r features'
alias bsc='bundle exec script/console'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'
#
# use macvim binary if present (it has ruby compiled)
# alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
# [[ -s "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && . alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias gitreset="git reset --hard origin/$(git branch | grep '*' | cut -d' ' -f2)"
alias gitpullr="git pull --rebase origin $(git branch | grep '*' | cut -d' ' -f2)"
# export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
alias tmux="TERM=screen-256color-bce tmux"
alias last_tag=$(git for-each-ref --sort='*authordate' --format='%(tag)' refs/tags | egrep "^${branch}\.[0-9]+$" | tail -n1)
# [[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
source ~/.profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
