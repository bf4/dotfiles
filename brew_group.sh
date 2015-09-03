# https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Tips-N'-Tricks.md
# https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/FAQ.md#my-mac-apps-dont-find-usrlocalbin-utilities
source ~/.shells/prompt.sh
whoami=$(whoami)
pwd=$(pwd)
set_perms() {
  local dir="$1"
  sudo chown -R "$whoami:brew" "$dir"
  # sudo chmod -R 664 "$dir"
  # see https://github.com/Homebrew/homebrew/issues/41942
  #     https://github.com/Homebrew/homebrew/issues/25952
  # 755 or 775
  # sudo chmod -R 775 "$dir"
}
last_commit_message() {
  git log -1 --pretty=%B | cat
  # git log -1 | cat
}
update_git() {
  local dir="$1"
  if [ -f "$dir/.git/config" ]; then
    cd "$dir"
    printf "in $(pwd)"
      last_commit_message
      git remote update
      git reset --hard origin/master
      last_commit_message

      find_git_status &&
      echo $'\t'
      printf " git status: ${git_status}"

      # This causes bottles to not be used
      # git commit -am "Update permission to 775" > /dev/null
      # echo $'\t'
      # find_git_status
      # printf " git status: ${git_status}"
    cd $pwd
    true
  else
    false
  fi
}
echo $'\nSetting brew permissions\n'
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
