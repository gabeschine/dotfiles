#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  cwd=$(pwd)
  for file in $(ls -1 -A | grep -E -w -v '^README.md|.git|.gitattributes|.gitmodules|.DS_Store|bootstrap.sh|LICENSE-MIT.txt|brew.sh|.hgignore|.gitignore|init$'); do
    if [ -L ../$file ]; then
      echo "Skipping $file"
      continue
    fi
    ln -siv $cwd/$file ..
  done
  source ~/.bash_profile;
  mkdir -p ~/.vim/swaps
  mkdir -p ~/.vim/undo
  mkdir -p ~/.vim/history
  mkdir -p ~/.vim/backups
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
