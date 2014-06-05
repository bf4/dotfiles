[[ -s "$HOME/.prompt_formatting" ]] && source "$HOME/.prompt_formatting"
[[ -s "$HOME/.shell_functions" ]] && source "$HOME/.shell_functions"
source ~/.profile
source `brew --repository`/Library/Contributions/brew_bash_completion.sh
[[ -s "$HOME/.shell_aliases" ]] && source "$HOME/.shell_aliases"
# use vi mode in terminal
set -o vi
