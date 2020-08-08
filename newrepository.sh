#!/bin/sh
repoName=$1
mkdir -p ~/github/$repoName

test -z $repoName && echo "Repo name required." 1>&2

curl -u 'mu71l473d' https://api.github.com/user/repos -d "{\"name\":\"$repoName\"}"

echo "# $repoName" >> README.md
git init
git add README.md
git commit -m "first commit for $repoName"
git remote add origin https://github.com/mu71l473d/$repoName.git
git push -u origin master
