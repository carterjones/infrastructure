#!/bin/bash

files_changed() {
    # Narrow to the last two merges to master (this and the prior one). Then
    # get the commit prior to this one and extract the commit id.
    last_merge_to_master=$(
        git log --all --grep="Merge branch.*into master" --oneline | \
            head -2 | \
            tail -1 | \
            sed "s/ .*//")

    # Get the files changed since the last merge to master.
    git diff --name-only HEAD $last_merge_to_master
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
