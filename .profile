export MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
export MOD_PATH=/usr/local/zend/mysql/bin:$MOD_PATH
export MOD_PATH=$HOME/.cabal/bin:$MOD_PATH
export PATH=$MOD_PATH:$PATH

export NODE_PATH="/usr/local/lib/node"
export PATH=$PATH:/usr/local/share/npm/bin
# export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH


export PATH="$HOME/.pollev/bin:$PATH"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"
# fortune
# use vi mode in terminal
set -o vi
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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
