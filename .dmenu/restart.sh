#!/bin/bash

declare options=("yes
quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Restart?')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	yes)
		sudo reboot
	;;
	*)
		exit 1
	;;
esac
