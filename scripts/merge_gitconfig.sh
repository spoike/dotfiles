#!/usr/bin/env zsh

SOURCE_CONFIG=("${(f)$(cat mergeable\/.gitconfig)}")
CATEGORY="core"
for i in $SOURCE_CONFIG
do
  if [[ "$i" =~ "^\[.*\]" ]]; then
    CATEGORY="$(echo $i | grep -o '[a-z]\+')"
    continue
  fi
  if [[ -z "$i" ]]; then
    continue
  fi
  [[ $i =~ '([a-z0-9\-]+) *= *(.*)$' ]] && local KEY=$match[1] && local VALUE="$(echo $match[2] | sed -e 's/^"//' -e 's/"$//')"

  git config --global --get $CATEGORY.$KEY >/dev/null
  if [ ! $? -eq 0 ]; then
    echo "Missing in .gitconfig $CATEGORY.$KEY!"
    git config --global $CATEGORY.$KEY $VALUE >/dev/null
  fi

done
