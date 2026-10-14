#!/bin/bash
#This shell script is specifically designed for Ubuntu 25+

#If not run as root then exit
if (( $EUID != 0 )); then
    echo "SCRIPT MUST BE RUN AS ROOT" >&2
    exit 1
fi

#Update // Upgrade
apt-get update
apt-get upgrade -y

#Grab some basic packages
apt-get install micro
apt-get install ghostty
apt-get install curl
apt-get install git
apt-get install wget


sudo mkdir -p ./RobotoMonoFont
cd ./RobotoMonoFont
#Pull nerdfont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/RobotoMono.zip

#Unzip
unzip ./RobotoMono.zip

rsync -av ./RobotoMono /usr/local/fonts/
fc-cache -fv

#Step out of folder
cd ..

#Cleanup install folder
rm -rf ./RobotoMonoFont

#Get starship
curl -sS https://starship.rs/install.sh | sh

echo "eval '$(starship init bash)'" >> ~/.bashrc
source ~/.bashrc

select-editor

#Get UV Astral
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

#Setup Pastel Powerline
starship preset pastel-powerline -o ~/.config/starship.toml

#Setup config file
mkdir -p ~/.config && touch ~/.config/ubuntu-xdg-terminals.list
#Setup Ghostty
echo "com.mitchellh.ghostty.desktop" >> ~/.config/ubuntu-xdg-terminals.list
