#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems.
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

defaultinstall.sh () {
	#update;
	#installfromapt;
	#installfromaptgui;
	#installpentest;
	#installvbguest;
	#installvmwareguest;			
	#installgrub;
	#clonegitrepos;
	#configuregnomebar;
	#installspotify;
	#installptf;
	#installwine;
	#installsumatrapdf;
	#installvmware;
	#installdropbox;
	#installsublime;
	#installhd;
	#installffdev;
	installiotre;
}



update () {
	sudo apt update
	sudo apt upgrade
}

installfromapt () {
	update;
	sudo apt install -y apt-transport-https git gdb gcc python3 cmake make curl p7zip-full p7zip-rar; 
}

installfromaptgui () {
	update;	
	sudo apt install -y qbittorrent thunderbird vlc cherrytree wine-stable
}

installpentest () {
	sudo apt install -y exiftool wireshark tmux seclists ftp php-curl python-smb mingw-w64
}

installvbguest () {
	apt install -y build-essential dkms
}

installvmwareguest () {
	sudo apt install -y open-vm-tools open-vm-tools-desktop fuse
}


clonegitrepos () {
	sudo mkdir  ~/Github/
	cd ~/Github
	git config --global user.name "mu71l473d"
	git config --global credential.helper cache
	git clone https://github.com/mu71l473d/PublicBashScripts.git;
	git clone https://github.com/mu71l473d/BashScripts.git;
	#git clone https://github.com/mu71l473d/BookNotes.git; 
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
	git clone https://github.com/mu71l473d/PublicPythonScripts.git;
	git clone https://github.com/mu71l473d/mu71l473d.github.io.git;
	git clone https://github.com/mu71l473d/PublicPowerShellScripts.git;
	git clone https://github.com/mu71l473d/MagicMirror.git;
	git clone https://github.com/mu71l473d/CProgrammingLanguage.git;

	ln -s ./PublicBashScripts/uploadtogithub.sh .
	
}

installptf () {
	cd ~
	git clone https://github.com/trustedsec/ptf.git
	./ptf
	#use modules/install_update_all
	#yes
}

installsublime () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update && sudo apt upgrade
}

configuregnomebar () {
	#set bar to bottom
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
	#set applications button to left
	gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
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
	cd ./SumatraPDF
	mv Sumatra*.exe SumatraPDF.exe
	mv sumatra*.exe SumatraPDF.exe
	cd ~/Desktop

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

installhd () {
        ##installs a 1080p mode for kali/ubuntu/etc.
	xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
	xrandr --addmode Virtual1 1920x1080
	xrandr --output Virtual1 --mode 1920x1080

	
}

installffdev () {

    FIREFOX_DESKTOP="[Desktop Entry]\nName=Firefox Developer\nGenericName=Firefox Developer Edition\nExec=/opt/firefox_dev/firefox\nTerminal=false\nIcon=/opt/firefox_dev/browser/icons/mozicon128.png\nType=Application\nCategories=Application;Network;X-Developer;\nComment=Firefox Developer Edition Web Browser."
    
    curl -o releases.txt https://download-installer.cdn.mozilla.net/pub/devedition/releases/
    VERSION=$(grep -o '[0-9][0-9]\.[0-9][a-z][0-9]' releases.txt | tail -1)    
    rm releases.txt    

    # Get download file name.
    FILE=firefox-$VERSION.tar.bz2

    # Create /opt/firefox-dev if it doesn't exist.
    if [ ! -d "/opt/firefox-dev" ]
    then 
        sudo mkdir /opt/firefox-dev
    fi

    # Get Firefox download.
    curl -o $FILE https://download-installer.cdn.mozilla.net/pub/devedition/releases/$VERSION/linux-x86_64/en-US/$FILE

    # If you don't get the file you specified, you get an HTML file with a 
    #'404 Not found' text in it.
    if grep -iq '404 Not found' $FILE 
    then
        clear
        echo Error...
        echo $FILE did not download.
        rm $FILE
        exit 
    fi

    # Unzip the install file.
    tar xvjf $FILE

    # Clear the target directory.
    sudo rm -rf /opt/firefox-dev/*

    # Move the program files to the target directory.
    sudo mv firefox/* /opt/firefox-dev

    # Remove the unzipped install folder.
    rm -rf firefox

    # Remove the install file.
    rm $FILE
    
    echo -e ${FIREFOX_DESKTOP} > ~/.local/share/applications/firefox_dev.desktop
    
    
    echo "Firefox Dev Ed $1 installed."
    
    
    
}

installiotre () {
	sudo apt install binwalk openocd flashrom firmware-mod-kit killerbee hackrf ubertooth ubertooth-firmware gqrx gqrx-sdr multimon-ng dex2jar radare2 
}

defaultinstall.sh

