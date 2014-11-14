[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

for src in \
  "$HOME/.prompt_formatting" \
  "$HOME/.shell_aliases" \
  "$HOME/.shell_functions"
do
  source "$src"
done

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# vim in shell
set -o vi
