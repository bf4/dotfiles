LANG=en_US
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
function add_to_mod_path {
  [[ -s $1 ]] &&
      export MOD_PATH="$MOD_PATH:$1"
}
add_to_mod_path "/usr/local/zend/mysql/bin"
add_to_mod_path "$HOME/.cabal/bin"
add_to_mod_path "$HOME/.pollev/bin"
export PATH=$MOD_PATH:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
which git-jk &> /dev/null
if [ $? -eq 0 ]
then
  alias gitjk="history 10 | tail -r | gitjk_cmd"
  # echo "Node is at $(npm config get prefix)"
  #  NODE_PATH="/usr/local/lib/node_modules"
fi

# PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

# export RUBYOPT=-w
export EDITOR=vim
export VISUAL=vim
export PAGER=less
[[ -s '/usr/local/bin/hub' ]] && alias git=hub
# do not check GHI_TOKEN into source control
export GHI_TOKEN="wouldntyouliketoknow"
# chruby init
# source /usr/local/opt/chruby/share/chruby/chruby.sh
# export RUBIES=(
#   $HOME/.rubies/*
#   $HOME/.rvm/rubies/*
# )
# autoswitching on .ruby-version
# source /usr/local/opt/chruby/share/chruby/auto.sh
# rbenv init
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# [[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
# Node Version Manager
source $(brew --prefix nvm)/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -s `overcommit --template-dir` ]] && export GIT_TEMPLATE_DIR=`overcommit --template-dir`
