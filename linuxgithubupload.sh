#!/usr/bin/env sh

main

main () {
find . -type d -name .git \
 | xargs -n 1 dirname \
 | while read line; \
	do \
		cd $line \
		&& update \
		&& cd -; \
	done
}	

update () {
sudo git pull
sudo git add *
sudo git commit -m "new version"
sudo git push
echo "Done"
echo ""
echo ""
}