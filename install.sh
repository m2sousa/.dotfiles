#!/bin/bash

# Will fail in some cases (e.g. non git directories), but who cares ? I don't
if [ $(git rev-parse --show-toplevel) != $(pwd) ]; then
    echo "Please run the install.sh script from the root of the git repo."
    echo "  -> Currently at $(pwd)"
    exit 1
fi

CONFIG_FILES=$(find .config/ -type f -print)

for f in $CONFIG_FILES; do
    mkdir -vp $HOME/${f%/*}
    ln -vfs $(pwd)/$f $HOME/$f 2> /dev/null
done

WALLPAPERS_FILES=$(find img/ -type f -print)

for f in $WALLPAPERS_FILES; do
    DEST=.config/wallpapers/${f#img/}
    mkdir -vp "$HOME/${DEST%/*}"
    ln -vfs "$(pwd)/$f" "$HOME/$DEST" 2>/dev/null
done
