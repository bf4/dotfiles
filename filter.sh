filter() {
  local filename=$1
  git filter-branch --force --index-filter \
    "git rm --cached --ignore-unmatch ${filename}" \
    --prune-empty --tag-name-filter cat -- --all

  echo "${filename}" >> .gitignore
  git extend

  git push bf4 --force --all

  git push bf4 --force --tags
}

