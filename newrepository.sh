#!/bin/sh
repoName="$1"


echo "# $1" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/mu71l473d/$1.git
git push -u origin master
