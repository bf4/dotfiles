#!/usr/bin/env sh
alias mkdir="mkdir -p"

alias ber='bundle exec rake'
alias bounce='touch tmp/restart.txt'
alias be='bundle exec'

# http://blog.tdg5.com/sixty-bash-tastic-git-aliases/
# up: cd to root of git repo, home dir, then root
# This shortcut is the creation of my former co-worker, Nicholas Ellis. It allows you to navigate toward the root of a file-system with stops at a few convenient paths. If you're in a git repo, the first call to up will cd you to the root of the git repo. From the root of a git repo, a call to up will take you to your home directory. Finally, from your home directory, a call to up will take you to the root of the file-system
alias up='[ $(git rev-parse --show-toplevel 2>/dev/null || echo ~) = $(pwd) ] && cd $([ $(echo ~) = $(pwd) ] && echo / || echo) || cd $(git rev-parse --show-toplevel 2>/dev/null)'

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
# Won't add newline when piped, e.g. shrug | pbcopy
shrug() { printf "%s" '¯\_(ツ)_/¯'; if [ -t 1 ]; then printf "\n"; fi  }

alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
