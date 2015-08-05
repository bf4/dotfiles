# Added by the Heroku Toolbelt
[[ -s "/usr/local/heroku/bin" ]] && export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f "$HOME/$DOTFILES_HOME/.travis/travis.sh" ] && source "$HOME/$DOTFILES_HOME/.travis/travis.sh"

[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# https://github.com/andsens/homeshick/wiki/Installation
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

# added by travis gem
[ -f /Users/bfleischer/.travis/travis.sh ] && source /Users/bfleischer/.travis/travis.sh
