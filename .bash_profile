export RUBYOPT=-w
export MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
export MOD_PATH=/usr/local/zend/mysql/bin:$MOD_PATH
export MOD_PATH=$HOME/.cabal/bin:$MOD_PATH
export PATH=$MOD_PATH:$PATH

export NODE_PATH="/usr/local/lib/node"
export PATH=$PATH:/usr/local/share/npm/bin
# export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

[[ -s "$HOME/.shell_functions" ]] && source "$HOME/.shell_functions"
[[ -s "$HOME/.prompt_formatting" ]] && source "$HOME/.prompt_formatting"
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"
fortune
# use vi mode in terminal
set -o vi
source ~/.profile
# [[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
