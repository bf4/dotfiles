#!/usr/bin/env sh
# brew install bash_completion
# Homebrew's own bash completion script has been installed to
#   /usr/local/etc/bash_completion.d
#
#   Bash completion has been installed to:
#     /usr/local/etc/bash_completion.d
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi
# shell_name=$(echo $0 | cut -d- -f2)
# shell_completions_file="$(brew --repository)/Library/Contributions/brew_$(echo $0 | cut -d- -f2)_completion.sh"
# [ -s $shell_completions_file ] && source $shell_completions_file
# handle various places git completion may be
# if [ -s `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
#   echo "using homebrew git completion"
# elif [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
#   # echo "using apple git completion for /usr/bin/git"
#   source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
# else
#   # fall back to local (linked) copy
#   echo "using local git completion"
#   source $HOME/.git-completion.sh
#   # maybe see brew install bash-completion
#   # source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
# fi
# brew install grc
[ -s "`brew --prefix grc`/etc/grc.bashrc" ] && source "`brew --prefix grc`/etc/grc.bashrc"

# Set git autocompletion and PS1 integration for showing git info in terminal
# https://github.com/iambowen/dotfiles/blob/master/bash_profile
# https://gist.github.com/ryknow/3303462/raw/2e2f9dd271f3caa83a435965664e59f0dd4626dc/.bashrc

ps1_set() {
  export PS1="\$(__my_rvm_prompt)\[\e[36m\]$(__my_git_prompt)\[\e[0m\]\w\n📝 $ "
}
export PROMPT_COMMAND='ps1_set;ensure_update_terminal_cwd;'
