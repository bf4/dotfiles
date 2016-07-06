# https://github.com/andsens/homeshick/wiki/Installation
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# Added by the Heroku Toolbelt
[[ -s "/usr/local/heroku/bin" ]] && export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f "$HOME/$DOTFILES_HOME/.travis/travis.sh" ] && source "$HOME/$DOTFILES_HOME/.travis/travis.sh"

[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

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
