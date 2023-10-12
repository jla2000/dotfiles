#!/bin/bash

if grep open /proc/acpi/button/lid/LID/state; then
	hyprctl keyword monitor "eDP-2, 2560x1600@120,auto,1.2"
else
	if [[ $(hyprctl monitor | grep "Monitor" | wc -l) != 1 ]]; then
		hyprctl keyword monitor "eDP-2, disable"
	fi
fi
