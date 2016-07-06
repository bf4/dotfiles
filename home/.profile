# WARNING: if you delete .bash_profile, this file becomes part of bash's startup
# sequence, which means this file suddenly has to cater for two different
# shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load all files in ~/.envs
for function in ~/.envs/*; do
  source $function
done
export MY_EMAIL=${MY_EMAIL:-github@benjaminfleischer.com}
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
[ -s "$HOME/.ssh_agent.bash" ] && source "$HOME/.ssh_agent.bash"
# GIT
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
if which go > /dev/null; then
  unset GOROOT
  export GOPATH=${GOPATH:-$HOME/go}
  export PATH=$PATH:$GOPATH/bin
  # go env
  # go get github.com/tools/godep
  # e.g. build
  #   mkdir -p  $GOPATH/src/github.com/deis
  #   cd $GOPATH/src/github.com/deis
  #   git clone deis/deis
  #   export DEIS=$GOPATH/src/github.com/deis/deis
  #   cd $DEIS
  #   git remote add upstream https://github.com/deis/deis.git
fi
# HASKELL
[ -s $HOME/.cabal   ] && PATH="$HOME/.cabal/bin:$PATH"
# PYTHON
[ -s /usr/local/lib/python ] && export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
[ -s '/usr/local/bin/pyenv' ] && eval "$(pyenv init -)"
# NODE
[ -s "$HOME/.node/bin" ] && export PATH="$HOME/.node/bin:$PATH"
# Node Version Manager
# install: cp $(brew --prefix nvm)/nvm-exec ~/.nvm/
# to remove, delete, or uninstall nvm - just remove the `$NVM_DIR` folder (usually `~/.nvm`)
# mkdir -p /Users/bfleischer/.local/lib/python2.7/site-packages
# echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> /Users/bfleischer/.local/lib/python2.7/site-packages/homebrew.pth
nvm_sh=$(brew --prefix nvm)/nvm.sh
if [ -f $nvm_sh ]; then
  export NVM_DIR=~/.nvm
  source $nvm_sh
  export NODE_VERSION=${NODE_VERSION:-0.12.4}
  nvm use "$NODE_VERSION" 1> /dev/null
  nvm alias default "${NODE_VERSION}" 1> /dev/null
fi
# RUBY
# chruby init
# if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
#   source /usr/local/share/chruby/chruby.sh
#   chruby $(cat .ruby-version)
# fi
# autoswitching on .ruby-version
# source /usr/local/opt/chruby/share/chruby/auto.sh
# rbenv init
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#  Load RVM into a shell session *as a function*
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
