if grep -q /usr/local/bin/bash /private/etc/shells; then
  chsh -s "$(brew --prefix)/bin/bash"

  # Also, make sure that /usr/local/bin and /usr/local/sbin
  # are in your $PATH variable before the regular /usr/bin and /usr/sbin.
  # where brew --prefix is /usr/local
  # See .profile
  # [ -s /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
  # [ -s /usr/local/sbin ] && PATH="/usr/local/sbin:$PATH"

  # turn on recursive globbing
  shopt -s globstar
fi
