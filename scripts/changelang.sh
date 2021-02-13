#!/bin/bash

layout=$(setxkbmap -query | grep layout)
hello='heo'
if [[ $layout =~ us ]]; then
  setxkbmap -model abnt2 -layout no
  setxkbmap -query | grep layout
else
  setxkbmap -model abnt2 -layout us
  setxkbmap -query | grep layout
fi
