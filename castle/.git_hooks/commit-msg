#!/bin/sh
#
# A hook script that checks the length of the commit message.
#
# Called by "git commit" with one argument, the name of the file
# that has the commit message. The hook should exit with non-zero
# status after issuing an appropriate message if it wants to stop the
# commit. The hook is allowed to edit the commit message file.

DEFAULT="\033[0m"
YELLOW="\033[1;33m"

function printWarning {
    message=$1
    printf >&2 "${YELLOW}$message${DEFAULT}\n"
}

function printNewline {
    printf "\n"
}

function captureUserInput {
    # Assigns stdin to the keyboard
    exec < /dev/tty
}

function confirm {
    question=$1
    read -p "$question [y/n]"$'\n' -n 1 -r
}

messageFilePath=$1
message=$(cat $messageFilePath)
firstLine=$(printf "$message" | sed -n 1p)
firstLineLength=$(printf ${#firstLine})

test $firstLineLength -lt 51 || {
    printWarning "Tip: the first line of the commit message shouldn't be longer than 50 characters and yours was $firstLineLength."
    captureUserInput
    confirm "Do you want to modify the message in your editor or just commit it?"

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $EDITOR $messageFilePath
    fi

    printNewline
    exit 0
}
