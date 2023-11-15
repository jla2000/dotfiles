#!/usr/bin/env bash

INTERNAL=eDP-1
EXTERNAL=DisplayPort-1-0

grep -q closed /proc/acpi/button/lid/LID/state

if [ $? = 0 ]; then
	xrandr --output ${INTERNAL} --off
	xrandr --output ${EXTERNAL} --auto
else
	xrandr --output ${INTERNAL} --auto
	xrandr --output ${EXTERNAL} --off
fi
