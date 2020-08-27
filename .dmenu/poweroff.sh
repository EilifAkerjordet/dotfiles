#!/bin/bash

declare options=("yes
quit")

choice=$(echo -e "${options[@]}" | dmenu -i -p 'Power off?')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	yes)
		sudo poweroff
	;;
	*)
		exit 1
	;;
esac
