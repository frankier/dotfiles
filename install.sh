#!/bin/zsh
setopt extendedglob
for f (${0%/*}/^install.sh) ln -s $f:a ~/.$f:t
