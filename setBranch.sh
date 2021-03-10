#!/usr/bin/env bash
clear
options=()
#for bash version 4 or higher use mapfile.
#Fallback to while loop if mapfile not found
mapfile -t options < <(git for-each-ref --format='%(refname:short)' refs/remotes/ | grep $1 | cut -c 8-) &>/dev/null || while read line; do options+=( "$line" ); done 
    < <(git for-each-ref --format='%(refname:short)' refs/remotes/ | grep $1 | cut -c 8-)
options+=('Exit')
select opt in "${options[@]}"
do
    if [[ "$opt" ]] && [[ "$opt" == 'Exit' ]]; then
        echo "Bye Bye"
        exit 0
    elif [[ "$opt" ]]; then
        git checkout "$opt"
    else
        echo "Wrong Input. Please enter the correct input"
    fi
done
