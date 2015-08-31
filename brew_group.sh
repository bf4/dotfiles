source ~/.shells/prompt.sh
whoami=$(whoami)
pwd=$(pwd)
set_perms() {
  local dir="$1"
  sudo chown -R "$whoami:brew" "$dir"
  sudo chmod -R 775 "$dir"
}
update_git() {
  local dir="$1"
  if [ -f "$dir/.git/config" ]; then
    cd "$dir"
    printf "in $(pwd)"
      find_git_status &&
      echo $'\t'
      printf " git status: ${git_status}"
      git commit -am "Update permission to 775" > /dev/null
      echo $'\t'
      find_git_status
      printf " git status: ${git_status}"
    cd $pwd
    true
  else
    false
  fi
}
for lib in \
  "/usr/local" \
  "/Library/Caches/Homebrew" \
  "/Library/Caches/Homebrew/Casks" \
  "/opt/homebrew-cask" \
  "/opt/homebrew-cask/Caskroom" \
  "/usr/local/Cellar/brew-cask/$(brew cask --version)" \
  ; do
  printf $lib
  set_perms "$lib"
  update_git "$lib"
  echo $'\n'
done
taps_dir="/usr/local/Library/Taps"
find $taps_dir -maxdepth 2 -type d | while read dir; do
  set_perms "$dir"
  update_git "$dir" && echo $'\n'
done
echo $'\n'
