# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOTFILES_HOME=${DOTFILES_HOME:-.homesick/repos/dotfiles/home}
[ -f "$HOME/$DOTFILES_HOME/.profile" ] && source "$HOME/$DOTFILES_HOME/.profile" # Load the default .profile

setopt shwordsplit
# Load all files in ~/.shells
for function in ~/.shells/*; do
  source $function
done
unsetopt shwordsplit

# Load all files in ~/.zsh
for function in ~/.zsh/*; do
  source $function
done

# vim in shell
# set -o vi

[[ -s "/usr/local/heroku/bin" ]] && export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f "$HOME/$DOTFILES_HOME/.travis/travis.sh" ] && source "$HOME/$DOTFILES_HOME/.travis/travis.sh"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


export PATH="$HOME/.bin:$PATH"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
