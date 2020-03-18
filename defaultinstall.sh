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
	#installmobilepentest;
	#installicspentest;
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
	#installsublime;
	#installhd;
	#installffdev;
	#installiotre;
	#cloneptrepos;
	#settzdata;
	#addaliases;
}



update () {
	sudo apt update
	sudo apt upgrade -y
}

installfromapt () {
	update;
	sudo apt install -y apt-transport-https git gcc python3 python3-pip python3-venv cmake make curl p7zip-full p7zip-rar; 
}

installfromaptgui () {
	update;	
	sudo apt install -y qbittorrent thunderbird vlc cherrytree wine
}

installpentest () {
	update;
	sudo apt install -y exiftool gdb wireshark tmux seclists gobuster ftp php-curl python-smb mingw-w64
	if [ -n "$(uname -a | grep Kali)"]; then
	sudo apt install kali-linux-everything -y
	fi
}

installmobilepentest () {
	update;
	sudo apt install -y android-apktool androick android-sdk android-sdk-platform-tools androidpincrack androidsniffer androwarn androbugs androguard apkstudio backdoor-apk backhack dex2jar drozer kwetza lazydroid androbugs
}

installicspentest () {
	sudo mkdir -p /opt/icstools/ && cd /opt/icstools	
	
	git clone https://github.com/theralfbrown/smod-1
		echo "[*] smod-1 requires python 2.7. You should consider not using it anymore"
	
	git clone https://github.com/w3h/isf
		echo "[*] the industrial security exploitation framework (ISF) requires python 2.7"
	
	git clone https://github.com/threat9/routersploit
		echo "[*] routersploit"
		cd routersploit
		apt install libglib2.0-dev
		python3 -m pip install -r requirements.txt
		python3 -m pip install bluepy
		cd ..
	
	git clone https://github.com/nsacyber/GRASSMARLIN
	
	git clone https://github.com/digitalbond/Redpoint
		cd Redpoint
			sudo cp *.nse /usr/share/nmap/scripts
			echo "[*] scripts copied. "
		cd ..
	git clone https://github.com/moki-ics/modscan
		
	git clone https://github.com/SCADACS/PLCinject
	
	git clone https://github.com/yanlinlin82/plcscan

	git clone https://github.com/0xICF/SCADAShutdownTool/tree/

	git clone https://github.com/moki-ics/moki
		cd moki
			chmod +x setup.sh
			./setup.sh --all
		cd ..

	git clone https://github.com/ControlThingsTools/cti2c
		echo "a python 2.7 tool for interfacing with i2c connections"

	git clone https://github.com/ControlThingsTools/ctserial
		echo "a swiss army knife for interfacing with serial"
		cd ctserial
		pip3 install -r requirements.txt
		cd ..


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
	cd /opt/
	git clone https://github.com/trustedsec/ptf.git
	cd /opt/ptf
	chmod +x ptf
	sudo ./ptf --update-all
}

installsublime () {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update && sudo apt install sublime-text -y
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
	update;
	sudo apt install wine-stable
	winecfg
}

installsumatrapdf () {
	installwine;
	SUMATRAPDF_DESKTOP="[Desktop Entry]\nVersion=3.1.2-prerelease\nType=Application\nName=SumatraPDF_Prerelease\nExec=wine /opt/SumatraPDF/SumatraPDF.exe %F\nIcon=/opt/SumatraPDF/SumatraPDF.png"
	cd /opt/
	git clone https://github.com/mu71l473d/SumatraPDF.git
	sudo chown $USER:$USER /opt/SumatraPDF
	cd /opt/SumatraPDF
	
	mv Sumatra*.exe SumatraPDF.exe
	sudo echo -e ${SUMATRAPDF_DESKTOP} > /usr/share/applications/SumatraPDF.desktop
    	sudo echo -e ${SUMATRAPDF_DESKTOP} > ~/Desktop/SumatraPDF.desktop
}


installgrub () {
	update;	
	sudo apt install grub
	grub-mkinstall
	sudo update-grub
}

installvmware () {
   	cd ~/Downloads
   	wget -O ~/vmware.bin https://www.vmware.com/go/getworkstation-linux
    	sudo apt install build-essential
    	sudo apt --fix-broken install
    	sudo bash ~/Downloads/vmware.bin
}

installhd () {
        ##installs a 1080p mode for kali/ubuntu/etc.
	xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
	xrandr --addmode Virtual1 1920x1080
	xrandr --output Virtual1 --mode 1920x1080
	echo "Also don't forget to check if the /etc/default/grub config file is configured for 1080p. Then run update-grub to update the bootloader"
}

installffdev () {

    FIREFOX_DESKTOP="[Desktop Entry]\nName=Firefox Developer\nGenericName=Firefox Developer Edition\nExec=/opt/firefox-dev/firefox\nTerminal=false\nIcon=/opt/firefox-dev/browser/chrome/icons/default/default128.png\nType=Application\nCategories=Application;Network;X-Developer;\nComment=Firefox Developer Edition Web Browser."
    
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

    # make current user the owner of the firefox folder
    sudo chown $USER:$USER /opt/firefox-dev

    # Remove the unzipped install folder.
    rm -rf firefox

    # Remove the install file.
    rm $FILE
    
    sudo echo -e ${FIREFOX_DESKTOP} > /usr/share/applications/firefox-dev.desktop
    sudo echo -e ${FIREFOX_DESKTOP} > ~/Desktop/firefox-dev.desktop
       
    echo "Firefox Dev Ed $1 installed."
   
}

installiotre () {
	sudo apt install binwalk openocd flashrom firmware-mod-kit killerbee hackrf ubertooth ubertooth-firmware gqrx gqrx-sdr multimon-ng dex2jar radare2 
}

cloneptrepos () {
	echo "[+] Installing Qark"
	echo "[+] this project requires python3 and pip installed.\n"
	echo "[+] on debian based systems it can be installed with: sudo apt install python3 python3-pip"
	cd /opt
	git clone https://github.com/linkedin/qark
	cd qark
	#It can also be called with pip3 install
	pip3 install -r requirements.txt
	pip3 -m pip install . 
	qark --help
	echo "Qark is installed\n"	
}

settzdata () {
	sudo dpkg-reconfigure tzdata
	#also set time from gui until scripted. ntp service can be added.
}

addaliases () {
	echo -n "alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove && cd /opt/ptf && sudo ./ptf --update-all -y'\nalias lal='ls -al'\nalias serviceunits='systemctl list-units --type=service'\nalias status='systemctl status'\nalias restart='systemctl restart'\nalias edgerouter='ssh -i ~/.ssh/edgerouter admin@edgerouter.kiwapentest.nl'\nalias cloudkey='ssh -i ~/.ssh/cloudkey admin@cloudkey.kiwapentest.nl'\nalias qownnotes='/opt/QOwnNotes/QOwnNotes.AppImage & >/dev/null 2>&1'\nalias autorecon='python3 /opt/AutoRecon/autorecon.py'" >> ~/.bashrc

	source ~/.bashrc
}

defaultinstall.sh
