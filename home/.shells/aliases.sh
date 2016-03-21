#!/usr/bin/env sh
alias mkdir="mkdir -p"

alias b="bundle"
alias ber='bundle exec rake'
alias bes='bundle exec rspec -fs'
alias bec='bundle exec cucumber -r features'
alias bsc='bundle exec rails s'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'
# https://twitter.com/rwjblue/status/536637409547808768
# When running into issues with npm/bower it's a good idea to clear out
# the cache. This is because pulled packages are still cached on the local
# system but don't exist upstream.
alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'
# https://github.com/BlakeWilliams/dotfiles/blob/668acd6e8ebbd8844422ffbd63b6ad823330a27a/.zsh/aliases.zsh#L10-L13
alias killphantom="pkill -9 -f phantomjs"

alias migrate="rake db:migrate db:rollback && rake db:migrate"
alias drop="rake db:drop && rake db:create && rake db:migrate"

# alias tmux="TERM=screen-256color-bce tmux"
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"
#
# use macvim binary if present (it has ruby compiled)
# alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
# [[ -s "/Applications/MacVim.app/Contents/MacOS/Vim" ]] && alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"

# alias ctags="`brew --prefix`/bin/ctags"
