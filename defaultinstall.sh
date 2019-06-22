#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems.
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

defaultinstall.sh () {
	update;
	installfromapt;
	installfromaptgui;
	#installpentest;
	#installvbguest;
	#installvmwareguest;			
	#installgrub;
	#11clonegitrepos;
	#installspotify;
	#installptf;
	#installwine;
	#installsumatrapdf;
	#installvmware;
	#installdropbox;
	#installsignal;
}



update () {
	sudo apt update
	sudo apt upgrade
}

installfromapt () {
	#update;
	sudo apt install git gdb gcc python3 cmake make curl p7zip-full p7zip-rar; 
}

installfromaptgui () {
	#update;	
	sudo apt install qbittorrent thunderbird vlc cherrytree torbrowser-laucher wine-stable
}

installpentest () {
	sudo apt install exiftool wireshark tmux
}

installvbguest () {
	apt install build-essential dkms
}

installvmwareguest () {
	sudo apt install open-vm-tools
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
	git clone https://github.com/mu71l473d/JavaProjects.git;
	git clone https://github.com/mu71l473d/hacking-taoe.git;
	git clone https://github.com/mu71l473d/PublicPythonScripts.git
	git clone https://github.com/mu71l473d/mu71l473d.github.io.git
	git clone https://github.com/mu71l473d/PublicPowerShellScripts.git
	git clone https://github.com/mu71l473d/MagicMirror.git
	git clone https://github.com/mu71l473d/CProgrammingLanguage.git
	
	sudo cp ./BashScripts/uploadtogithub.sh .
	
}

installptf () {
	cd ~
	git clone https://github.com/trustedsec/ptf.git
	./ptf
	#use modules/install_update_all
	#yes
}

installsignal () {
	curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	update;
	sudo apt install signal-desktop
}

installspotify () {
	# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

	# 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

	# 3. Update list of available packages
	update;

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

installvmware () {
    cd ~/Downloads
    wget -O ~/vmware.bin https://www.vmware.com/go/getworkstation-linux
    sudo apt install build-essential
    sudo apt --fix-broken install
    sudo bash ~/Downloads/vmware.bin
}

installdropbox () {
    cd ~/Downloads
    wget -O - https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2018.11.28_amd64.deb
    sudo dpkg -i dropbox_2018.11.28_amd64.deb
}


defaultinstall.sh

