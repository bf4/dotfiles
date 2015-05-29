# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load all files in ~/.envs
for function in ~/.envs/*; do
  source $function
done
export MY_EMAIL=${MY_EMAIL:-github@benjaminfleischer.com}
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PAGER=less
export LESS=' -R '
export LESSCHARSET=utf-8 # don't print out unicode as e.g. <E2><80><99>
export PROJECTS_DIR="$HOME/projects"
export DOTFILES_HOME=${DOTFILES_HOME:-.homesick/repos/dotfiles/home}
# User Scripts
[ -s "$HOME/bin"    ] && PATH="$HOME/bin:$PATH"
# HOMEBREW
[ -s /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
[ -s /usr/local/sbin ] && PATH="/usr/local/sbin:$PATH"
# HOMEBREW CASK
[ -s /opt/bin       ] && PATH="/opt/bin:$PATH"
[ -s /opt/local/bin ] && PATH="/opt/local/bin:$PATH"
# SSH
[ -s "$HOME/${DOTFILES_HOME}/ssh_agent.bash" ] && source "$HOME/${DOTFILES_HOME}/ssh_agent.bash"
# VIM
export EDITOR=vim
export VISUAL=vim
# GIT
# http://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
export GIT_EDITOR=vim
# EMAIL is the fallback email address in case the user.email configuration value isn’t set.
# If this isn’t set, Git falls back to the system user and host names.
export EMAIL=${EMAIL:-$MY_EMAIL}
## HUB (github git extender)
[ -s '/usr/local/bin/hub' ] && eval "$(hub alias -s)"
## GHI
# do not check GHI_TOKEN into source control
# export GHI_TOKEN="wouldntyouliketoknow"
# PostgreSQL
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
# GO
if which go > /dev/null; then export GOPATH=${GOPATH:-$HOME/gocode}; fi
# HASKELL
[ -s $HOME/.cabal   ] && PATH="$HOME/.cabal/bin:$PATH"
# PYTHON
[ -s /usr/local/lib/python ] && export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
[ -s '/usr/local/bin/pyenv' ] && eval "$(pyenv init -)"
# RUBY
# export RUBYOPT=-w
# Die spring die!
export DISABLE_SPRING=1
## RVM
#  Add RVM to PATH for scripting 
[ -s $HOME/.rvm/bin ] && export PATH="$PATH:$HOME/.rvm/bin"
#  Load RVM into a shell session *as a function* 
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
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
# NODE
[ -s "$HOME/.node/bin" ] && export PATH="$HOME/.node/bin:$PATH"
# Node Version Manager
nvm_sh=$(brew --prefix nvm)/nvm.sh
if [ -f $nvm_sh ]; then
  export NVM_DIR=~/.nvm
  source $nvm_sh
fi
