#!/bin/bash
#install firefox from the command line

firefox.sh(){
    sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora &&
    sudo apt-get update &&
    sudo apt-get install firefox
}
