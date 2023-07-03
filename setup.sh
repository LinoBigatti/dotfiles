#!/bin/sh

Color_Off='\033[0m'
BRed='\033[1;31m' BGreen='\033[1;32m' BYellow='\033[1;33m' BBlue='\033[1;34m'

DIR=`pwd`
FONT_DIR="$HOME/.local/share/fonts"

if [[ -z "$1" ]]; then
	echo -e ${BRed}"[!] Usage: ./setup.sh <theme>" ${Color_Off}

	echo -e ${BYellow}"\n[*] Available themes:" ${Color_Off}
	echo -e ${BBlue}"    [-] bedrock" ${Color_Off}
	echo -e ${BBlue}"    [-] satellite" ${Color_Off}
	echo -e ${BBlue}"    [-] voyager" ${Color_Off}
	
	exit 1
fi

echo -e ${BGreen}"[*] Installing dotfiles..." ${Color_Off}

echo -e ${BBlue}"\n[*] Stowing files..." ${Color_Off}
stow -R --dotfiles -t $HOME $1-theme i3 bumblebee-status rofi picom redshift sakura vim zsh

echo -e ${BBlue}"\n[*] Installing fonts..." ${Color_Off}
if [[ -d "$FONT_DIR" ]]; then
	cp -rf $DIR/fonts/* "$FONT_DIR"
else
	mkdir -p "$FONT_DIR"
	cp -rf $DIR/fonts/* "$FONT_DIR"
fi

echo -e ${BYellow}"[*] Updating font cache..." ${Color_Off}
fc-cache

echo -e ${BGreen}"\n[*] Successfully Installed." ${Color_Off}
