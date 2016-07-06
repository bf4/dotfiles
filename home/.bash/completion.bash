#!/usr/bin/env sh
_source_if_exists() {
  [ -f "$1" ] && source "$1"
}
# brew install bash_completion
# Homebrew's own bash completion script has been installed to
#   /usr/local/etc/bash_completion.d
#
#   Bash completion has been installed to:
#     /usr/local/etc/bash_completion.d
_source_if_exists "$(brew --prefix)/etc/bash_completion"

# shell_name=$(echo $0 | cut -d- -f2)
# shell_completions_file="$(brew --repository)/Library/Contributions/brew_$(echo $0 | cut -d- -f2)_completion.sh"
# [ -s $shell_completions_file ] && source $shell_completions_file

# If Commandline tools are installed without Xcode.app,
# we'll fall back to local git completion
# handle various places git completion may be
# if not using homebrew git completion
if [ ! -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
  if [ -s /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
    # echo "using apple git completion for /usr/bin/git"
    source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
  else
    # fall back to local (linked) copy
    # echo "using local git completion"
    source $HOME/.git-completion.sh
    # maybe see brew install bash-completion
    # source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
  fi
fi
# brew install grc
_source_if_exists "$(brew --prefix grc)/etc/grc.bashrc"

_source_if_exists "$(brew --prefix)/etc/bash_completion.d/go"

# https://github.com/basecamp/sub/blob/bb93f151df9e4219ae4153c83aad63ee6494a5d8/completions/sub.bash
_ws() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(ws commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(ws completions "$command")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _ws ws
