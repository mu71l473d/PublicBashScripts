#!/bin/bash
RED='\033[0;31m'
NOCOLOR='\033[0m'

update () {
cd ~/github
currentdir=$(pwd)

for D in *; do
if [ -d "${D}" ]; then
	cd "$currentdir/${D}"
	echo
	echo -e "${RED}$(pwd)${NOCOLOR}"
	sudo git pull
	sudo git add *
	sudo git commit -m "new version"
	sudo git push
	cd ..
fi
done
}
update;

echo "Done with Uploading"

