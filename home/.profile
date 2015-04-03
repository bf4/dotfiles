# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export MY_EMAIL=${MY_EMAIL:-githu@benjaminfleischer.com}
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
export DISABLE_SPRING=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim
# http://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
export GIT_EDITOR=vim
# EMAIL is the fallback email address in case the user.email configuration value isn’t set.
# If this isn’t set, Git falls back to the system user and host names.
export EMAIL=${EMAIL:-$MY_EMAIL}

export VISUAL=vim
export PAGER=less
export PROJECTS_DIR="$HOME/projects"
[ -s /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
[ -s "$HOME/bin"    ] && PATH="$HOME/bin:$PATH"
[ -s /opt/bin       ] && PATH="/opt/bin:$PATH"
[ -s /opt/local/bin ] && PATH="/opt/local/bin:$PATH"
[ -s $HOME/.cabal   ] && PATH="$HOME/.cabal/bin:$PATH"
[ -s /usr/local/lib/python ] && export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
[ -s '/usr/local/bin/hub' ] && eval "$(hub alias -s)"
export DOTFILES_HOME=${DOTFILES_HOME:-.homesick/repos/dotfiles/home}
[[ -s "$HOME/${DOTFILES_HOME}/../ssh_agent.bash" ]] && source "$HOME/${DOTFILES_HOME}/../ssh_agent.bash"
shell_name=$(echo $0 | cut -d- -f2)
if [ $shell_name == "bash" ]
then
  # see
  # http://stackoverflow.com/questions/338285/prevent-duplicates-from-being-saved-in-bash-history#answer-7449399
  # http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
  # avoid duplicates..
  # https://github.com/companygardener/dotfiles/blob/b76d3a83f46b3d70e7d75573e2fc5728730f9c38/home/bashrc
  export HISTFILESIZE=300000
  export HISTIGNORE="&:ls:[bf]g:exit:history"
  # export HISTCONTROL=ignoreboth
  export HISTCONTROL=ignoredups:erasedups
  export HISTSIZE=100000
  # append history entries..
  shopt -s histappend
  shopt -s checkwinsize

  # After each command, save and reload history
  # export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a;
  # history -c; history -r"
elif [ $shell_name == "zsh" ]
then
  # http://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
  setopt share_history
fi
source "$(brew --repository)/Library/Contributions/brew_$(echo $0 | cut -d- -f2)_completion.sh"

# export RUBYOPT=-w
# do not check GHI_TOKEN into source control
# export GHI_TOKEN="wouldntyouliketoknow"
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
[ -s "$HOME/.node/bin" ] && export PATH="$HOME/.node/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
