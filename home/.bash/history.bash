#!/usr/bin/env sh

# see
# http://stackoverflow.com/questions/338285/prevent-duplicates-from-being-saved-in-bash-history#answer-7449399
# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# avoid duplicates..
# https://github.com/companygardener/dotfiles/blob/b76d3a83f46b3d70e7d75573e2fc5728730f9c38/home/bashrc

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# https://debian-administration.org/article/543/Bash_eternal_history
# https://ptspts.blogspot.com/2011/03/how-to-automatically-synchronize-shell.html
# https://github.com/pts/pts-merge-history-bash/blob/master/merge_history.bash
HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

_bash_history_sync() {
  # Step 1 ensures that the command from the current running session gets written to the global history file.
  builtin history -a         # Append the just entered line to the $HISTFILE (default is .bash_history). This will cause $HISTFILE to grow by one line.

  HISTFILESIZE=$HISTSIZE     # Setting the special variable $HISTFILESIZE to some value will cause Bash to truncate $HISTFILE to be no longer than $HISTFILESIZE lines by removing the oldest entries.
  builtin history -c         # Clear the history of the running session. This will reduce the history counter by the amount of $HISTSIZE.
  # Step 4 ensures that the commands from the other sessions gets read in to the current session history.
  # Because step 4 will raise the history counter, we need to reduce the counter in some way. This is done in step 3.
  # In step 3 the history counter is reduced by $HISTSIZE. In step 4 the history counter is raised by the number of lines in $HISTFILE. In step 2 we make sure that the line count of $HISTFILE is exactly $HISTSIZE (this means that $HISTFILESIZE must be the same as $HISTSIZE).
  builtin history -r         # Read the contents of $HISTFILE and insert them in to the current running session history. this will raise the history counter by the amount of lines in $HISTFILE. Note that the line count of $HISTFILE is not necessarily $HISTFILESIZE.
}

history() {                  # The history() function overrides the builtin history to make sure that the history is synchronised before it is displayed. This is necessary for the history expansion by number (more about this later).
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND="_bash_history_sync; $PROMPT_COMMAND"

# append to the history file, don't overwrite it
shopt -s histappend

# reedit a history substitution line if it failed
shopt -s histreedit
# edit a recalled history line before executing
shopt -s histverify
