#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems.
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

defaultinstall.sh () {
	installfromapt;
	#installgrub;
	clonegitrepos;
	#installspotify;
	#installptf;
	#installwine;
	installsumatrapdf;
}



installfromapt () {
	sudo apt update;
	sudo apt upgrade;
	sudo apt install git gdb gcc python python3 qbittorrent eclipse thunderbird tor vlc cherrytree; 
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
}

installptf () {
	cd ~
	git clone https://github.com/trustedsec/ptf.git
	./ptf
	#use modules/install_update_all
	#yes
}

installspotify () {
	sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free" &&
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 &&
        sudo apt-get update &&
        sudo apt-get install spotify-client -y --allow-unauthenticated
}
 

installwine () {
	sudo dpkg --add-architecture i386
	wget -nc https://dl.winehq.org/wine-builds/Release.key
	sudo apt-key add Release.key
	sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
	sudo apt update
	sudo apt-get install --install-recommends winehq-stable
	winecfg
}

installsumatrapdf () {
	installwine;
	mkdir ~/Github
	cd ~/Github/ 
	git clone https://github.com/mu71l473d/SumatraPDF.git
	cd ./SumatraPDF
	sudo cp SumatraPDF.desktop /usr/share/applications/
}


installgrub () {
	sudo apt install grub;
	grub-mkinstall;
	sudo update-grub;
}

defaultinstall.sh
