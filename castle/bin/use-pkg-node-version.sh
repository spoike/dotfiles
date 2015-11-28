#!/usr/bin/env bash
#
# Switches to node version with nvm to the one defined in package.json
# Dependencies: nvm, jq
# Usage: Alias this by sourcing with ".", e.g. alias nnn='. ~/bin/use-pkg-node-version.sh'

if [ ! -e package.json ]; then
    echo "Missing package.json file"
    return 1
fi

PKG_VERSION=$(jq '.engines.node' package.json)
VERSION=$(echo $PKG_VERSION | sed -E 's/"[<>=]*([0-9]([\.0-9a-z]+)?)*.*"/\1/')
NVM_VERSION=$(node -v)

verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

if [ $VERSION == "null" ]; then
    echo "There is no version defined in package.json"
    return 1
fi

echo $(echo "Version found $PKG_VERSION") $(echo "Currently $NVM_VERSION")

if verlt v$VERSION $NVM_VERSION; then
    echo "Current node version ($NVM_VERSION) is newer than the project's ($VERSION)"
    return
fi

if ! nvm use $VERSION ; then
    while true; do
        read -p "Would you like to install version $VERSION?" yn
        case $yn in
            [Yy]* ) nvm install $VERSION && nvm use $VERSION; break;;
            [Nn]* ) return;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi


