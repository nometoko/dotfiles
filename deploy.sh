#!/bin/sh

for file in $(ls -A | grep -vE '\.git$|\.gitignore$|\.sh$|README.md$|\.DS_Store$|\.config$'); do
    target=${HOME}/${file}
    if [ -e $target ]; then
        if [ -L $target ]; then
            resolved=$(readlink -f $target)
            if [ "$resolved" != "$(readlink -f $file)" ]; then
                echo -n "$target already exists. Do you want to overwrite it? [y/N]: "
                read answer
                if [ "$answer" != "${answer#[Yy]}" ]; then
                    unlink $target
                    ln -sf $(readlink -f $file) $target
                    echo "[symbolic link] $target -> $(readlink -f $file)"
                fi
            fi
        else
            echo "$target already exists. Do you want to overwrite it? (y/N)"
            read answer
            if [ "$answer" != "${answer#[Yy]}" ]; then
                mv $target ${target}.bak
                ln -sf $(readlink -f $file) $target
                echo "[symbolic link] $target -> $(readlink -f $file)"
            fi
        fi
    else
        rm -rf $target
        ln -s $(readlink -f $file) $target
        echo "[symbolic link] $target -> $(readlink -f $file)"
    fi
done

for file in $(find .config -maxdepth 1 -mindepth 1 | grep -vE '\.DS\_Store$'); do
    target=${HOME}/${file}
    if [ -f $target ] || [ -d $target ]; then
        if [ -L $target ]; then
            resolved=$(readlink -f $target)
            if [ "$resolved" != "$(readlink -f $file)" ]; then
                echo -n "$target already exists. Do you want to overwrite it? [y/N]: "
                read answer
                if [ "$answer" != "${answer#[Yy]}" ]; then
                    unlink $file
                    ln -sf $(readlink -f $file) $target
                    echo "[symbolic link] $target -> $(readlink -f $file)"
                fi
            fi
        else
            echo -n "$target already exists. Do you want to overwrite it? [y/N]: "
            read answer
            if [ "$answer" != "${answer#[Yy]}" ]; then
                mv $target ${target}.bak
                ln -sf $(readlink -f $file) $target
                echo "[symbolic link] $target -> $(readlink -f $file)"
            fi
        fi
    else
        ln -s $(readlink -f $file) $target
        echo "[symbolic link] $target -> $(readlink -f $file)"
    fi
done
