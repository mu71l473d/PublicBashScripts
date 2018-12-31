#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems.
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

defaultinstall.sh () {
	installfromapt;
	#installgrub;
	#clonegitrepos;
	#installspotify;
	#installptf;
	#installwine;
	#installsumatrapdf;
}



installfromapt () {
	sudo apt update;
	sudo apt upgrade;
	sudo apt install git gdb gcc python python3 qbittorrent eclipse thunderbird vlc cherrytree torbrowser-launcher wine-stable; 
}


clonegitrepos () {
	sudo mkdir  ~/Github/
	cd ~/Github
	git config --global user.name "mu71l473d"
	git config --global credential.helper cache
	git clone https://github.com/mu71l473d/PublicBashScripts.git;
	git clone https://github.com/mu71l473d/BashScripts.git;
	git clone https://github.com/mu71l473d/BookNotes.git; 
	git clone https://github.com/mu71l473d/GreyBlackHatPython.git; 
	git clone https://github.com/mu71l473d/PythonScripts.git;
	git clone https://github.com/mu71l473d/PowershellScripts.git;
	git clone https://github.com/mu71l473d/BanditChallenge.git;
	git clone https://github.com/mu71l473d/TTN-private-routing.git;
	git clone https://github.com/mu71l473d/JavaProjects.git;
	git clone https://github.com/mu71l473d/hacking-taoe.git;
	git clone https://github.com/mu71l473d/SecurityManagement.git;
	git clone https://github.com/mu71l473d/nodejs-cert.git;
	git clone https://github.com/mu71l473d/PublicPythonScripts.git
	
	sudo cp ./BashScripts/uploadtogithub.sh .
	
}

installptf () {
	cd ~
	git clone https://github.com/trustedsec/ptf.git
	./ptf
	#use modules/install_update_all
	#yes
}

installspotify () {
	# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

	# 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

	# 3. Update list of available packages
	sudo apt update

	# 4. Install Spotify
	sudo apt install spotify-client -y 
}
 

installwine () {
	sudo apt update && sudo apt upgrade
	sudo apt install wine-stable
	winecfg
}

installsumatrapdf () {
	installwine;
	cd /opt/
	git clone https://github.com/mu71l473d/SumatraPDF.git
	sudo chown mu71l473d:mu71l473d ./SumatraPDF
	cd ./SumatraPDF/
	sudo cp SumatraPDF.desktop /usr/share/applications/
}


installgrub () {
	sudo apt install grub;
	grub-mkinstall;
	sudo update-grub;
}

defaultinstall.sh
