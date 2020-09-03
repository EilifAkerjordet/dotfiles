#!/bin/sh

choice= echo -e "Yes\nNo" | dmenu -i -p "Power Off?"
if [[ $choice ==: "yes" ]]; then echo "hei"; fi
