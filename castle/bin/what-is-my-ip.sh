#!/usr/bin/env zsh
# Pull out ip addy from ifconfig

IP=$(ifconfig | awk '/eth0/,/Scope:Link/' | awk 'match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) { print substr($0, RSTART, RLENGTH) }' | tr -d '\n')
printf %s "$IP"
