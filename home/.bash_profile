# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[ -f "$HOME/$DOTFILES_HOME/.bashrc" ] && source "$HOME/$DOTFILES_HOME/.bashrc"
[ -f "$HOME/$DOTFILES_HOME/.profile" ] && source "$HOME/$DOTFILES_HOME/.profile" # Load the default .profile

# Load all files in ~/.shells
for function in ~/.shells/*; do
  source $function
done
# Load all files in ~/.bash
for function in ~/.bash/*; do
  source $function
done

# vim in shell
set -o vi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
