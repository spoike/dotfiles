#!/usr/bin/env bash
#
# Switches to node version with nvm to the one defined in package.json
# Dependencies: nvm, jq

if [ ! -e package.json ]; then
    echo "Missing package.json file"
    exit 1
fi

PKG_VERSION=$(jq '.engines.node' package.json)
VERSION=$(echo $PKG_VERSION | sed -E 's/"[<>=]*([0-9]([\.0-9a-z]+)?)*.*"/\1/')
NVM_VERSION=$(node -v)

if [ ! $VERSION == "null" ]; then
    echo "Version $VERSION is defined in package.json"
    exit 1
fi

TMPFILE=$(mktemp package.json.XXXXX)

jq ".engines.node=\"${NVM_VERSION:1}\"" package.json | cat > $TMPFILE
#echo $TMPFILE
#cat $TMPFILE
echo "Added node version ${NVM_VERSION} to engines parameter in package.json"
mv -v $TMPFILE package.json
