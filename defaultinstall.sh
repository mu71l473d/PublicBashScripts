#!/bin/bash
#A simple installscript that makes (re)installing tools a lot easier

installfromapt(){
sudo apt update;
sudo apt upgrade;
sudo apt install git python; 
}


clonegitrepos(){
cd /opt/
git clone https://github.com/mu71l473d/PublicBashScripts.git
git clone https://github.com/mu71l473d/BashScripts.git
git clone https://github.com/mu71l473d/BookNotes.git https://github.com/mu71l473d/GreyBlackHatPython.git 




 

}
