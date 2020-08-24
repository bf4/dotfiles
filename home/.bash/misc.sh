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

# https://medium.com/opendoor-labs/cleaning-up-branches-with-githubs-squash-merge-43138cc7585e
git-prune-merged-squashed() {
  git checkout master &&
    comm -12 <(
      git branch | sed "s/ *//g"
    ) <(
      git remote prune origin | sed "s/^.*origin\///g"
    ) |
   xargs -L1 -J % git branch -D %
}

# https://github.com/not-an-aardvark/git-delete-squashed
git-delete-squashed() {
  local mergeBase
  git checkout -q master &&
    git for-each-ref refs/heads/ "--format=%(refname:short)" |
    while read branch; do
      mergeBase=$(git merge-base master $branch) &&
        [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] &&
        git branch -D $branch;
    done
}
