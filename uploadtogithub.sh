#!/bin/bash

update () {
sudo git pull
sudo git add *
sudo git commit -m "new version"
sudo git push
echo "Done"
echo ""
echo ""
}



echo "BashScripts"
cd ~/Github/BashScripts
update;

echo "PublicBashScripts"
cd ~/Github/PublicBashScripts
update;

echo "BanditChallenge"
cd ~/Github/BanditChallenge
update;

echo "GreyBlackHatPython"
cd ~/Github/GreyBlackHatPython
update;

echo "hacking-taoe"
cd ~/Github/hacking-taoe
update;

echo "JavaProjects"
cd ~/Github/JavaProjects
update;

echo "PowershellScripts"
cd ~/Github/PowershellScripts
update;

echo "PublicPythonScripts"
cd ~/Github/PublicPythonScripts
update;

echo "PythonScripts"
cd ~/Github/PythonScripts
update;

echo "Books and booknotes"
cd /media/mu71l473d/Datadisk/books/
update;

echo "PublicPowershellScripts"
cd ~/Github/PublicPowerShellScripts
update;

echo "hackdecamera"
cd ~/Github/hackcamera
update;

echo "Kiwashop"
cd ~/Github/juice-shop
update;

echo "Done with Uploading"
