#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
  files=$(rsync --exclude ".git/" --exclude ".gitmodules" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "diff.sh" \
    --exclude "README.md" --exclude "LICENSE-MIT.txt" -ah -rvnc --no-perms . ~ | \
    grep -v '/$' | grep -v "building file" | grep -v "bytes/sec" | grep -v "total size" | grep -v '^$')
  for f in $files; do
    echo
    echo "==========  $f  ==========="
    /usr/bin/diff $f ../$f
  done
}

doIt;
unset doIt;
