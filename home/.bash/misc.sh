# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias peek='tee >(cat 1>&2)'

# git-branch-history() {
#   git reflog | grep 'checkout: moving' | head -20 | awk '{ print $6,\"\t\t\t\t\",$8 }'
# }
git-unmerged-branch-history() {
  comm -12 <(git branch | awk '{ print $1 }' | sort) <(
    comm -23 <(
      git reflog | grep 'checkout: moving' | head -100 | awk '{ print $8 }' | sort -u | grep -v master
    ) <(
      git branch master --no-merged | sort
    )
  )
}
