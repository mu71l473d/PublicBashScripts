#!/bin/bash
#A simple installscript that makes (re)installing tools that i enjoy using a lot easier. For now it only works on Ubuntu/Debian/Kali based systems.
#uncomment the functions you need
#@author Rene Bisperink
#@version 0.2

defaultinstall.sh () {
	chown -R $USER:$USER /opt
	#update;
	#installfromapt;
	#installfromaptgui;
	#installpentest;
	#installmobilepentest;
	#installicspentest;
	#installvmwareguest;			
	#installgrub;
	#clonegitrepos;
	#configuregnomebar;
	#configurexfce;
	#installspotify;
	#installptf;
	#installwine;
	#installsumatrapdf;
	#fixvmwarekernel;
	#installvmware;
	#installffdev;
	#installiotre;
	#settzdata;
	#addaliases;
	#buildattify
	#buildsamurai

	
}
update () {
	sudo apt update
	sudo apt upgrade -y
}

installfromapt () {
	update;
	sudo apt install -y apt-transport-https git reptyr gcc python3 python3-pip python3-venv cmake make curl p7zip-full p7zip-rar; 
}

installfromaptgui () {
	update;	
	sudo apt install -y qbittorrent thunderbird vlc cherrytree
}

installpentest () {
	update;
	sudo apt install -y exiftool wine64 gdb wireshark wine seclists gobuster ftp php-curl python3-smb mingw-w64
	if [ -n "$(uname -a | grep Kali)"]; then
		sudo apt install kali-linux-large -y
	fi
}

installmobilepentest () {
	update;
	sudo mkdir -p /opt/android
	#install useful tools
	sudo apt install -y python3-venv apktool android-sdk adb androguard dex2jar
	
	#install mobsf
	cd /opt/android/
	git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF
	cd Mobile-Security-Framework-MobSF/
	apt install python3-venv
	pip3 install wkhtmltopdf
	chmod +x setup.sh
	chmod +x run.sh
	./setup.sh
	./run.sh

	#install qark
	apt install python3-pip
	pip3 install --user qark

	ln -s /root/.local/bin/qark /usr/local/bin/qark

	echo "The qark version is: "
	qark --version

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

installvmwareguest () {
	sudo apt install -y open-vm-tools open-vm-tools-desktop fuse
}


clonegitrepos () {
	sudo mkdir  ~/github/
	cd ~/github
	git config --global user.name "mu71l473d"
	git config --global credential.helper cache
	git clone https://github.com/mu71l473d/publicbashscripts.git;
	git clone https://github.com/mu71l473d/bashscripts.git;
	#git clone https://github.com/mu71l473d/booknotes.git; 
	git clone https://github.com/mu71l473d/greyblackhatpython.git; 
	git clone https://github.com/mu71l473d/pythonscripts.git;
	git clone https://github.com/mu71l473d/powershellscripts.git;
	git clone https://github.com/mu71l473d/banditchallenge.git;
	git clone https://github.com/mu71l473d/javaprojects.git;
	git clone https://github.com/mu71l473d/hacking-taoe.git;
	git clone https://github.com/mu71l473d/publicpythonscripts.git;
	git clone https://github.com/mu71l473d/mu71l473d.github.io.git;
	git clone https://github.com/mu71l473d/publicpowershellscripts.git;
	git clone https://github.com/mu71l473d/magicmirror.git;
	git clone https://github.com/mu71l473d/cprogramminglanguage.git;
	git clone https://github.com/mu71l473d/cheatsheets.git;
	git clone https://github.com/mu71l473d/training-boxes.git;
	git clone https://github.com/mu71l473d/juice-shop;
	
	ln -s ./publicbashscripts/uploadtogithub.sh .
}

installptf () {
	cd /opt/
	git clone https://github.com/trustedsec/ptf.git
	cd /opt/ptf
	chmod +x ptf
	sudo ./ptf --update-all
}


configuregnomebar () {
	#set bar to bottom
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
	#set applications button to left
	gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
}

configurexfce () {
	cd /usr/share/themes
	sudo git clone https://github.com/mu71l473d/xfce-ubuntu-style
	sudo git clone https://github.com/B00merang-Project/Windows-10-Dark
	sudo xfconf-query -c xfwm4 -p /general/theme -s xfce-ubuntu-style
	sudo xfconf-query -c xsettings -p /Net/ThemeName -s xfce-ubuntu-style
	sudo cp -rf xfce-ubuntu-style/Windows-10-Icons /usr/share/icons
	sudo xfconf-query -c xsettings -p /Net/IconThemeName -s Windows-10-Icons	
}
installsignal () {
	curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	update;
	sudo apt install signal-desktop
}

installspotify () {
	# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
	
	# 2. add the repository to the sources.list
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

	# 3. Update list of available packages
	update;

	# 4. Install Spotify
	sudo apt install spotify-client -y 
}
 

installwine () {
	update;
	sudo apt install wine64
	winecfg
}

installsumatrapdf () {
	echo "Downloading sumatrapdf from this script does not work. The easiest way until it is fixed is to download the .exe manually and drop it in the /opt/SumatraPDF folder."
	installwine;
	SUMATRAPDF_DESKTOP="[Desktop Entry]\nVersion=3.1.2-prerelease\nType=Application\nName=SumatraPDF_Prerelease\nExec=wine /opt/SumatraPDF/SumatraPDF.exe %F\nIcon=/opt/SumatraPDF/SumatraPDF.png"
	cd /opt/
	sudo git clone https://github.com/mu71l473d/SumatraPDF.git
	sudo chown $USER:$USER /opt/SumatraPDF
	cd /opt/SumatraPDF
	
	#curl -o releases.xml http://kjkpub.s3.amazonaws.com/
	
	#VERSIONNUMBER=$(grep -Eo 'software/sumatrapdf/daily/SumatraPDF-prerel-[0-9][0-9][0-9][0-9][0-9]-64.exe' releases.txt | tail -1)    
	#echo "the versionnumber is $VERSIONNUMBER""
	#rm releases.xml

	#curl -O SumatraPDF.exe kjkpub.s3.amazonaws.com/$VERSIONNUMBER

	mv Sumatra*.exe SumatraPDF.exe
	sudo echo -e ${SUMATRAPDF_DESKTOP} > /usr/share/applications/SumatraPDF.desktop
    	sudo echo -e ${SUMATRAPDF_DESKTOP} > ~/Desktop/SumatraPDF.desktop
}

fixvmwarekernel () {
	cd /usr/lib/vmware/modules/source
	tar -xf vmnet.tar
	cd vmnet-only
	make
	cd ..
	tar -xf vmmon.tar
	cd vmmon-only
	make
	cd ..
	cp vmmon.o /lib/modules/`uname -r`/misc/vmmon.ko
	cp vmnet.o /lib/modules/`uname -r`/misc/vmnet.ko
	depmod -a
	systemctl restart vmware
}

installgrub () {
	update;	
	sudo apt install grub
	grub-mkinstall
	sudo update-grub
}

installvmware () {
   	cd ~/Downloads
   	wget -O vmware.bin https://www.vmware.com/go/getworkstation-linux
    	sudo apt install build-essential
    	sudo apt --fix-broken install
    	sudo bash ~/Downloads/vmware.bin
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
       
    echo "Firefox Dev Ed $VERSION installed."
   
}

installiotre () {
	sudo apt install binwalk openocd flashrom firmware-mod-kit killerbee hackrf ubertooth ubertooth-firmware multimon-ng dex2jar radare2 
}

settzdata () {
	timedatectl set-timezone Europe/Amsterdam
}

addaliases () {
	ALIASES="alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove && cd /opt/ptf && sudo ./ptf --update-all -y'\nalias lal='ls -al'\nalias serviceunits='systemctl list-units --type=service'\nalias status='systemctl status'\nalias restart='systemctl restart'\nalias qownnotes='/opt/QOwnNotes/QOwnNotes.AppImage & >/dev/null 2>&1'\nalias autorecon='python3 /opt/AutoRecon/autorecon.py'" 
	echo -e ${ALIASES} >> ~/.bashrc
	echo -e ${ALIASES} >> ~/.zshrc
	source ~/.bashrc
	source ~/.zshrc
}

buildsamurai () {
	mkdir /opt/samurai
	cd /opt/samurai
	sudo apt install nginx curl docker.io docker-compose unzip python3 php-fpm nano npm yarn wpscann zap burpsuite sqlmap nikto openjdk-11-jdk openjdk-11-jre
	git clone --depth 1 https://github.com/andresriancho/w3af.git
}

buildattify () {
mkdir /opt/attify
cd /opt/attify
	sudo apt install binwalk firmware-mod-kit gnuradio gqrx-sdr hackrf gr-osmosdr inspectrum jadx kalibrate-rtl nmap radare2 radare2-cutter rfcat rtl-sdr rtl-433 rtlsdr-scanner ubertooth
	sudo git clone https://github.com/NationalSecurityAgency/ghidra
# to install: 
#    Arduino
#    Baudrate
#    BDAddr
#    BetterCap
#    +Binwalk
#    Create_AP
#    Cutter
#    DspectrumGUI
#    Dump1090
#    Firmadyne
#    Firmware Analysis Toolkit (FAT)
#    +Firmware-Mod-Kit (FMK) 
#    +GHIDRA
#    +GNURadio
#    +GQRX
#    GR-GSM
#    GR-Paint
#    +HackRF Tools
#    +Inspectrum
#    +JADx
#    +Kalibrate-RTL
#    KillerBee
#    LibMPSSE
#    Liquid-DSP
#    LTE-Cell-Scanner
#    +NMAP
#    OOK-Decoder
#    Qiling
#    +radare2
#    +RFCat
#    RouterSploit
	apt-get install python3-pip
	git clone https://www.github.com/threat9/routersploit
	cd routersploit
	python3 -m pip install -r requirements.txt
	python3 rsf.py
	#  bluetooth low energy support
	apt-get install libglib2.0-dev
	python3 -m pip install bluepy
	python3 rsf.py	
	cd ..
#    +RTL-433
#    +RTL-SDR tools
#    +Scapy
	pip3 install --pre scapy[complete]
#    Spectrum Painter
#    +Ubertooth tools-
#    URH (Universal Radio Hacker)
}
defaultinstall.sh
