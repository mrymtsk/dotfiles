#!/usr/bin/env bash

script_path=$(readlink -f "$0")
PWD=$(dirname "$script_path")
HOME=$(readlink -f "$1")

DIRS_TO_LINK=$(find "$PWD" -path "$PWD/.git" -prune -o -name '*.link' -type d -print)
FILES_TO_LINK=$(find "$PWD" -path "$PWD/.git" -prune -o -name '*.link' -type d -prune -o -name '*install.sh*' -type f -prune -o -type f -print)
for source_dir in $DIRS_TO_LINK; do
    target_dir=${source_dir/$PWD/$HOME}
    target_dir=${target_dir%.link}
    dirname=$(dirname "$target_dir")
    if [[ ! -d $dirname ]]; then
        mkdir -p "$dirname"
    fi
    ln -fnsv "$source_dir" "$target_dir"
done
for source_file in $FILES_TO_LINK; do
    target_file=${source_file/$PWD/$HOME}
    dirname=$(dirname "$target_file")
    if [[ ! -d $dirname ]]; then
        mkdir -p "$dirname"
    fi
    ln -fnsv "$source_file" "$target_file"
done
