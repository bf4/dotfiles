# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[ -f "$HOME/$DOTFILES_HOME/.bashrc" ] && source "$HOME/$DOTFILES_HOME/.bashrc"
[ -f "$HOME/$DOTFILES_HOME/.profile" ] && source "$HOME/$DOTFILES_HOME/.profile" # Load the default .profile

for src in \
  "$HOME/$DOTFILES_HOME/.prompt_formatting" \
  "$HOME/$DOTFILES_HOME/.shell_aliases" \
  "$HOME/$DOTFILES_HOME/.shell_functions"
do
  source "$src"
done

# vim in shell
set -o vi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
