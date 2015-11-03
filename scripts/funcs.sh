#!/usr/bin/env zsh

ok() {
  echo "\e[0;32mOK\e[0m\t$1"
}

msg() {
  echo "\e[0;36m$1\e[0m\t"
}

pipeEditor() {
  TMPFILE=`mktemp /tmp/bootstrap.sh.tmp.XXXXXXXXXX`
  cat > {$TMPFILE}
  ${EDITOR:-vim} ${TMPFILE} < /dev/tty > /dev/tty
  cat {$TMPFILE}
  rm {$TMPFILE}
}
