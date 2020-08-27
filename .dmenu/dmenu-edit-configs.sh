#!/bin/bash

declare options=("alacritty
awesome
neovim
picom
polybar
bspwm
sxhkd
vim
dmenu-scripts
zsh
quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Edit config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	awesome)
		choice="$HOME/.config/awesome/rc.lua"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
	;;
	bspwm)
		choice="$HOME/.config/bspwm/bspwmrc"
	;;
	sxhkd)
		choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	dmenu-scripts)
		choice="$HOME/.dmenu/dmenu-edit-configs.sh"
	;;
	picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
	polybar)
		choice="$HOME/.config/polybar/config"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac
alacritty -e nvim "$choice"
