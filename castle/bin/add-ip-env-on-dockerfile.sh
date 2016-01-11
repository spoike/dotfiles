#!/usr/bin/env zsh
#
# Adds proxy setting ENVs to Dockerfiles under the ./docker/ directory.

# Pull out ip addy from ifconfig
IP=$(ifconfig | awk '/eth0/,/Scope:Link/' | awk 'match($0, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) { print substr($0, RSTART, RLENGTH) }')

# String to add to Dockerfiles
envs="# Proxy workaround\nENV http_proxy http://${IP}:3128\nENV https_proxy http://${IP}:3128\n"

# Add string to Dockerfiles
for dockerfile in docker/**/Dockerfile*; do
  sed -i "2i ${envs}" $dockerfile
done
