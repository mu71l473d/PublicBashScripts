#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems. The preference is kali
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

testsetup.sh () {
	#update;
	#installfromapt;
	#installpentest;
	#installmobilepentest;
	installmobsf
	#configuregnomebar;
	#installptf;
	#installsublime;
	#installffdev;
	#installiotre;
	#cloneptrepos;
	#settzdata;
	#addaliases;
}

update () {
	sudo apt update
	sudo apt upgrade
}

installfromapt () {
	update;
	sudo apt install -y apt-transport-https git gdb gcc python3 cmake make curl p7zip-full p7zip-rar; 
}

installpentest () {
	update;

	if [ -n "$(uname -a | grep Kali)"]; then
		sudo apt install -y kali-linux-everything 
	fi

	sudo apt install -y exiftool wireshark tmux seclists ftp php-curl python-smb mingw-w64
}

installmobilepentest () {
	update;
	sudo apt install -y android-sdk android-sdk-platform-tools androguard dex2jar drozer
}

installmobsf (){
	apt install docker.io
	docker pull opensecurity/mobile-security-framework-mobsf
	docker run -it -p 8000:8000 opensecurity-mobile-security-framework-mobsf:latest
	echo "now open the browser on localhost:8000"
}

installptf () {
	cd /opt/
	git clone https://github.com/trustedsec/ptf.git
	cd ./ptf/
	chmod +x ptf
	./ptf --update-all

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

    # Remove the unzipped install folder.
    rm -rf firefox

    # Remove the install file.
    rm $FILE
    
    echo -e ${FIREFOX_DESKTOP} > /usr/share/applications/firefox-dev.desktop
       
    echo "Firefox Dev Ed $1 installed."
   
}

installiotre () {
	sudo apt install binwalk openocd flashrom firmware-mod-kit killerbee hackrf ubertooth ubertooth-firmware gqrx gqrx-sdr multimon-ng dex2jar radare2 hackrf libhackrf-dev libhackrf0
} 

cloneptrepos () {
	update;

	echo "[+] Installing Qark"
	echo "[+] this project requires python3 and pip installed.\n"
	echo "[+] on debian based systems it can be installed with: sudo apt install python3 python3-pip"
	cd /opt
	git clone https://github.com/linkedin/qark
	cd qark
	pip3 install -r requirements.txt
	pip3 -m pip install . 
	qark --help
	echo "Qark is installed\n"

	if [ -n "$(uname -a | grep Kali)"]; then
		sudo apt install -y seclists
	else
		sudo mkdir -p /usr/share/wordlists/
		cd /usr/share/wordlists/
		git clone https://github.com/danielmiessler/SecLists 
	fi

	cd /opt/
	git clone https://github.com/techgaun/github-dorks/
}


settzdata () {
	dpkg-reconfigure tzdata
	#also set time from gui until scripted. ntp service can be added.
}

addaliases () {
	echo "alias update='sudo apt update && sudo apt upgrade -y && cd /opt/ptf && sudo ./ptf --update-all -y'" >> ~/.bashrc
	echo "alias lal='ls -al'" >> ~/.bashrc
	echo "alias serviceunits='systemctl list-units --type=service'" >> ~/.bashrc
	echo "alias status='systemctl status'" >> ~/.bashrc
	echo "alias restart='systemctl restart'" >> ~/.bashrc
	source ~/.bashrc
}



testsetup.sh
