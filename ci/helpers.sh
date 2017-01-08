#!/bin/bash

files_changed() {
    base_parent=$(git log --pretty=%P -n 1 HEAD | cut -d" " -f1)
    git diff --name-only HEAD $base_parent
}

check_paths_of_interest() {
    paths_of_interest=$1
    paths_exist=false
    if [[ "$paths_of_interest" != "" ]]; then
        for path in ${paths_of_interest[*]}; do
            if files_changed | grep -q "^$path"; then
                paths_exist=true
                break
            fi
        done
    fi
    if [[ "$paths_exist" = "true" ]]; then
        return 0
    else
        return 1
    fi
}
