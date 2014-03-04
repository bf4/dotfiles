export MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
export MOD_PATH=/usr/local/zend/mysql/bin:$MOD_PATH
export MOD_PATH=$HOME/.cabal/bin:$MOD_PATH
export NODE_PATH=/usr/local/lib/node_modules
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export PATH=$MOD_PATH:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -s `overcommit --template-dir` ]] && export GIT_TEMPLATE_DIR=`overcommit --template-dir`
