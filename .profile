export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export PROJECTS_DIR="$HOME/projects"
[[ -s '/usr/local/bin/hub' ]] && eval "$(hub alias -s)"
export PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin:$PATH
[[ -s "$HOME/dotfiles/ssh_agent.bash" ]] && source "$HOME/dotfiles/ssh_agent.bash"
shell_name=$(echo $0 | cut -d- -f2)
if [ $shell_name == "bash" ]
then
  # see
  # http://stackoverflow.com/questions/338285/prevent-duplicates-from-being-saved-in-bash-history#answer-7449399
  # http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
  # avoid duplicates..
  export HISTCONTROL=ignoredups:erasedups
  # append history entries..
  shopt -s histappend

  # After each command, save and reload history
  export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a;
  history -c; history -r"
elif [ $shell_name == "zsh" ]
then
  # http://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
  setopt share_history
fi
source "$(brew --repository)/Library/Contributions/brew_$(echo $0 | cut -d- -f2)_completion.sh"


# export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
# MOD_PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:$HOME/bin
# function add_to_mod_path {
#   [[ -s $1 ]] &&
#       export MOD_PATH="$MOD_PATH:$1"
# }
# add_to_mod_path "/usr/local/zend/mysql/bin"
# add_to_mod_path "$HOME/.cabal/bin"
# add_to_mod_path "$HOME/.pollev/bin"
# export PATH=$MOD_PATH:$PATH
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# which git-jk &> /dev/null
# if [ $? -eq 0 ]
# then
#   alias gitjk="history 10 | tail -r | gitjk_cmd"
#   # echo "Node is at $(npm config get prefix)"
#   #  NODE_PATH="/usr/local/lib/node_modules"
# fi
#
# PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

# export RUBYOPT=-w
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
# source $(brew --prefix nvm)/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
