#!/usr/bin/env bash

set -eou pipefail

if command -v tmux &>/dev/null; then
  set +e
  brew upgrade tmux
  set -e
else
  brew install tmux
fi

if [ -e ~/.tmux/plugins/tpm ]; then
  unset CDPATH
  cd ~/.tmux/plugins/tpm
  git remote update && git pull --rebase
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
