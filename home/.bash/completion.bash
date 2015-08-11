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
