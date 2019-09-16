#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier. For now it only works on Ubuntu/Debian based systems. The preference is kali
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.1

testsetup.sh () {
	#update;
	#installfromapt;
	#installpentest;
	#configuregnomebar;
	#installptf;
	#installsublime;
	#installffdev;
	#installiotre;
	#cloneptrepos
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
	sudo apt install -y exiftool wireshark tmux seclists ftp php-curl python-smb mingw-w64
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
	sudo apt install binwalk openocd flashrom firmware-mod-kit killerbee hackrf ubertooth ubertooth-firmware gqrx gqrx-sdr multimon-ng dex2jar radare2
} 

cloneptrepos () {
	cd /usr/share/wordlists/
	git clone https://github.com/danielmiessler/SecLists
}

testsetup.sh
