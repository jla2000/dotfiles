#!/usr/bin/env bash

DEVICE="ASUE120A:00 04F3:319B Touchpad"

if xinput --list-props "${DEVICE}" | grep -q "Device Enabled (166):.*1"; then
	xinput disable "${DEVICE}"
else
	xinput enable "${DEVICE}"
fi
