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
  find . -type f -size "+${sizeinkb}k" | xargs du -sh
  # find . -type f -size +50000k -exec ls -lh {} \; | awk '{ print $9 ": " $5
}
# http://www.cyberciti.biz/faq/find-large-files-linux/
findsize() {
   du -xak .|sort -n|tail -50
   # print out stars and the length of the stars show the usage of each folder / file from smallest to largest on the box:
   # du -k | sort -n | perl -ne 'if ( /^(\d+)\s+(.*$)/){$l=log($1+.1);$m=int($l/log(1024)); printf  ("%6.1f\t%s\t%25s  %s\n",($1/(2**(10*$m))),(("K","M","G","T","P")[$m]),"*"x (1.5*$l),$2);}'
}
