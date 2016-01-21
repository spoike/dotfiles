#!/usr/bin/env zsh
# Pull out ip addy from ifconfig

ifconfig | awk '/eth0/,/Scope:Link/' | awk 'match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) { print substr($0, RSTART, RLENGTH) }'
