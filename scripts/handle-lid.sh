#!/usr/bin/env bash

INTERNAL=eDP-1
EXTERNAL=DisplayPort-1-0

grep -q closed /proc/acpi/button/lid/LID/state

if [ $? = 0 ]; then
	xrandr --output ${INTERNAL} --off
else
	xrandr --output ${INTERNAL} --auto
	xrandr --output ${EXTERNAL} --auto --right-of ${INTERNAL}
fi
