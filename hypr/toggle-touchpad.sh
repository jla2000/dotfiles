#!/usr/bin/env bash

TOUCHPAD_DEVICE="asue120a:00-04f3:319b-touchpad"
ENABLE_PROPERTY="device:$TOUCHPAD_DEVICE:enabled"
TIMEOUT_PROPERTY="general:cursor_inactive_timeout"

if hyprctl getoption $ENABLE_PROPERTY | grep -q "int: 1"; then
	hyprctl keyword $ENABLE_PROPERTY false
	hyprctl keyword $TIMEOUT_PROPERTY 1
else
	hyprctl keyword $ENABLE_PROPERTY true
	hyprctl keyword $TIMEOUT_PROPERTY 0
fi
