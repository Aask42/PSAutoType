#!/bin/bash

# Get the first argument
action=$1

echo "$action"

# Get the content of the paste.txt file
paste=$(cat ./paste.txt)

# Define the actions
declare -A actions
actions[a]="$paste"

# Validate we have this action
if [[ -z "${actions[$action]}" ]]; then
    echo "$action does not exist, sorry charlie!"
    exit 1
fi

# Select the right window in case we got clicked off
sleep 5

# Input all our commands
for (( i=0; i<${#actions[$action]}; i++ )); do
    char="${actions[$action]:$i:1}"
    if [[ "$char" == "{" || "$char" == "^" ]]; then
        osascript -e "tell application \"System Events\" to keystroke \"$char\""
        sleep 0.025
    else
        osascript -e "tell application \"System Events\" to keystroke \"$char\""
    fi
done
