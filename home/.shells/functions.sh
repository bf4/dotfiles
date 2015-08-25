#!/usr/bin/env sh
# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
# cd to the path of the front Finder window
# with some modifications
# and references to https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/osx/osx.plugin.zsh
# and https://github.com/jbtule/cdto
cdf() {
  target=`osascript -e \
    'tell application "Finder" \
      to \
      if (count of Finder windows) > 0 then \
        get POSIX path of (target of front Finder window as text)
    ' 2>/dev/null`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found or is search results' >&2
  fi
}
# open finder window in current dir
alias f='open -a Finder ./'

# ls -lS | head +10 # find largest files
# ls -lSr | tail -10 # find smallest files
findgt() {
  sizeinkb="$1"
  find . -type f -size "+${sizeinkb}k" -print0 | xargs -0 du -sh
  # find . -type f -size +50000k -exec ls -lh {} \; | awk '{ print $9 ": " $5
}
# http://www.cyberciti.biz/faq/find-large-files-linux/
findsize() {
   du -xak .|sort -n|tail -50
   # print out stars and the length of the stars show the usage of each folder / file from smallest to largest on the box:
   # du -k | sort -n | perl -ne 'if ( /^(\d+)\s+(.*$)/){$l=log($1+.1);$m=int($l/log(1024)); printf  ("%6.1f\t%s\t%25s  %s\n",($1/(2**(10*$m))),(("K","M","G","T","P")[$m]),"*"x (1.5*$l),$2);}'
}

gitreset() {
  local branch_name="$(git name-rev --name-only HEAD)"
  local remote_name="$(git config branch.${branch_name}.remote)"
  remote_name="${remote_name:-origin}"
  local ref="${remote_name}/${branch_name}"
  echo "Fetching and resetting ${ref}"
  git fetch "$remote_name"
  git reset --hard "${ref}"
}
# parse_git_branch() {
#   cat .git/HEAD | sed -e 's/^.*refs\/heads\///'
#   # git branch --no-color 2> /dev/null | sed -e '/^[^\*]/d' -e 's/^\*\ \(.*\)/(\1) /'
# }
# gitpullr() {
#   git pull --rebase origin $(git branch | grep '*' | cut -d' ' -f2)
# }
git_last_tag() {
  git for-each-ref --sort='*authordate' --format='%(tag)' refs/tags | egrep "^${branch}\.[0-9]+$" | tail -n1
}

# http://stackoverflow.com/a/1371215
fetch_remotes() {
  local pwd=$(pwd)
  find . -depth 1 -type d | while read dir ; do
    cd $dir
    echo "$(pwd)"
    if [ -f ".git/config" ]; then
      git remote update
    else
      echo "not a git remote"
    fi
    cd "$pwd"
  done
}

# http://stackoverflow.com/a/28804252
# Tino's answer
# requires bash 4 and above
# _timeout() {
#   (
#     set +b
#     sleep "$1" & "${@:2}" & wait -n
#     r=$?
#     kill -9 `jobs -p`; exit $r
#   )
# }
# Example: _timeout 5 longrunning_command args
# Example: { _timeout 5 producer || echo KABOOM $?; } | consumer
# Example: producer | { _timeout 5 consumer1; consumer2; }
# Example: { while date; do sleep .3; done; } | _timeout 5 cat | less
#
# Needs Bash 4 for wait -n
#
# Gives 137 if the command was killed, else the return value of the command.
# Works for pipes. (You do not need to go foreground here!)
# Works with internal shell commands or functions, too.
# Runs in a subshell, so no variable export into the current shell, sorry.
# If you do not need the return code, this can be made even simpler:
#
#   _timeout() { ( set +b; sleep "$1" & "${@:2}" & wait -n; kill -9 `jobs -p`; ) }
#   Notes:
#
#   Strictly speaking you do not need the ; in ; ), however it makes thing more consistent to the ;
# }-case. And the set +b probably can be left away, too, but better safe than sorry.
#
# Except for --forground (probably) you can implement all variants timeout supports.
# --preserve-status is a bit difficult, though. This is left as an exercise for the reader ;)
#
# This recipe can be used "naturally" in the shell (as natural as for flock fd):
#
# (
# set +b
# sleep 20 &
# {
#   YOUR SHELL CODE HERE
# } &
# wait -n
# kill `jobs -p`
# )
# However, as explained above, you cannot re-export environment variables into the enclosing shell
# this way naturally.

# Real world example: Time out __git_ps1 in case it takes too long (for things like slow SSHFS-Links):
#
# eval "__orig$(declare -f __git_ps1)" &&
#  __git_ps1() {
#   (
#     git() {
#       _timeout 0.3 /usr/bin/git "$@";
#     }
#   _timeout 0.3 __orig__git_ps1 "$@"
#   )
# }
#
# Edit3: git is a die-hard, so it needs a double-trick to work satisfyingly.
# OS X doesn't use bash 4 yet, nor does it have /usr/bin/timeout,
# so here's a function that works on OS X without homebrew or macports
# that is similar to /usr/bin/timeout (based on Tino's answer).
# Parameter validation, help, usage, and support for other signals are an exercise for reader.
# implement /usr/bin/timeout only if it doesn't exist
# [ -n "$(type -p timeout 2>&1)" ] || function timeout {
#   (
#     set -m +b
#     sleep "$1" &
#     SPID=${!}
#     ("${@:2}"; RETVAL=$?; kill ${SPID}; exit $RETVAL) &
#     CPID=${!}
#     wait %1
#     SLEEPRETVAL=$?
#     if [ $SLEEPRETVAL -eq 0 ] && kill ${CPID} >/dev/null 2>&1 ; then
#       RETVAL=124
#       # When you need to make sure it dies
#       #(sleep 1; kill -9 ${CPID} >/dev/null 2>&1)&
#       wait %2
#     else
#       wait %2
#       RETVAL=$?
#     fi
#     return $RETVAL
#   )
# }
#!/usr/bin/env bash

# mpapis's answer
# I was presented with a problem to preserve the shell context and allow timeouts,
# the only problem with it is it will stop script execution on the timeout -
# but it's fine with the needs I was presented
# safe_kill()
# {
#   ps aux | grep -v grep | grep $1 >/dev/null && kill ${2:-} $1
# }
#
# my_timeout()
# {
#   typeset _my_timeout _waiter_pid _return
#   _my_timeout=$1
#   echo "Timeout($_my_timeout) running: $*"
#   shift
#   (
#     trap "return 0" USR1
#     sleep $_my_timeout
#     echo "Timeout($_my_timeout) reached for: $*"
#     safe_kill $$
#   ) &
#   _waiter_pid=$!
#   "$@" || _return=$?
#   safe_kill $_waiter_pid -USR1
#   echo "Timeout($_my_timeout) ran: $*"
#   return ${_return:-0}
# }
# my_timeout 3 cd scripts
# my_timeout 3 pwd
# my_timeout 3 true  && echo true || echo false
# my_timeout 3 false && echo true || echo false
# my_timeout 3 sleep 10
# my_timeout 3 pwd
# with the outputs:
#
# Timeout(3) running: 3 cd scripts
# Timeout(3) ran: cd scripts
# Timeout(3) running: 3 pwd
# /home/mpapis/projects/rvm/rvm/scripts
# Timeout(3) ran: pwd
# Timeout(3) running: 3 true
# Timeout(3) ran: true
# true
# Timeout(3) running: 3 false
# Timeout(3) ran: false
# false
# Timeout(3) running: 3 sleep 10
# Timeout(3) reached for: sleep 10
# Terminated

# end result:
[ -n "$(type -p timeout 2>&1)" ] || timeout() {
  #!/bin/bash
  #
  # https://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay
  #
  # http://www.bashcookbook.com/bashinfo/source/bash-4.0/examples/scripts/timeout3
  # The Bash shell script executes a command with a time-out.
  # Upon time-out expiration SIGTERM (15) is sent to the process. If the signal
  # is blocked, then the subsequent SIGKILL (9) terminates it.
  #
  # Based on the Bash documentation example.

  # Hello Chet,
  # please find attached a "little easier"  :-)  to comprehend
  # time-out example.  If you find it suitable, feel free to include
  # anywhere: the very same logic as in the original examples/scripts, a
  # little more transparent implementation to my taste.
  #
  # Dmitry V Golovashkin <Dmitry.Golovashkin@sas.com>

  scriptName="${0##*/}"

  declare -i DEFAULT_TIMEOUT=9
  declare -i DEFAULT_INTERVAL=1
  declare -i DEFAULT_DELAY=1

  # Timeout.
  declare -i timeout=DEFAULT_TIMEOUT
  # Interval between checks if the process is still alive.
  declare -i interval=DEFAULT_INTERVAL
  # Delay between posting the SIGTERM signal and destroying the process by SIGKILL.
  declare -i delay=DEFAULT_DELAY

function printUsage() {
    cat <<EOF

Synopsis
    $scriptName [-t timeout] [-i interval] [-d delay] command
    Execute a command with a time-out.
    Upon time-out expiration SIGTERM (15) is sent to the process. If SIGTERM
    signal is blocked, then the subsequent SIGKILL (9) terminates it.

    -t timeout
        Number of seconds to wait for command completion.
        Default value: $DEFAULT_TIMEOUT seconds.

    -i interval
        Interval between checks if the process is still alive.
        Positive integer, default value: $DEFAULT_INTERVAL seconds.

    -d delay
        Delay between posting the SIGTERM signal and destroying the
        process by SIGKILL. Default value: $DEFAULT_DELAY seconds.

As of today, Bash does not support floating point arithmetic (sleep does),
therefore all delay/time values must be integers.
EOF
}

  # Options.
  while getopts ":t:i:d:" option; do
      case "$option" in
          t) timeout=$OPTARG ;;
          i) interval=$OPTARG ;;
          d) delay=$OPTARG ;;
          *) printUsage; exit 1 ;;
      esac
  done
  shift $((OPTIND - 1))

  # $# should be at least 1 (the command to execute), however it may be strictly
  # greater than 1 if the command itself has options.
  if (($# == 0 || interval <= 0)); then
      printUsage
      exit 1
  fi

  "$@" &
  cmd_pid=$(jobs -p | tail -1)

  # kill -0 pid   Exit code indicates if a signal may be sent to $pid process.
  (
      ((t = timeout))

      while ((t > 0)); do
          # sleep $interval &
          # kill -0 $$ || exit 0
          ((t -= interval))
      done

      # Be nice, post SIGTERM first.
      # The 'exit 0' below will be executed if any preceeding command fails.
      kill -s SIGTERM $cmd_pid && kill -0 $cmd_pid || exit 0
      sleep $delay
      kill -s SIGKILL $cmd_pid
  ) 2> /dev/null &

}
