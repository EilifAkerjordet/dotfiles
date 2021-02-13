#!/bin/sh

case ${MONS_NUMBER} in
    1)
        mons -o && bspc wm -r
        ;;
    2)
        mons -m && bspc wm -r
        ;;
    3)
        $HOME/.screenlayout/three_monitor_home.sh; sleep 2; bspc wm -r
        killall light-locker
        ;;
    *)
        # Handle it manually
        ;;
esac
