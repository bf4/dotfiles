if grep -q /usr/local/bin/bash /private/etc/shells; then
  if [[ /usr/local/bin/bash != $SHELL ]]; then
    chsh -s "$(brew --prefix)/bin/bash"
  fi

  # Also, make sure that /usr/local/bin and /usr/local/sbin
  # are in your $PATH variable before the regular /usr/bin and /usr/sbin.
  # where brew --prefix is /usr/local
  # See .profile
  # [ -s /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
  # [ -s /usr/local/sbin ] && PATH="/usr/local/sbin:$PATH"

  # turn on recursive globbing
  # If set, the pattern "**" used in a pathname expansion context will
  # match all files and zero or more directories and subdirectories.
  shopt -s globstar
fi
