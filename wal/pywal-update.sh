#!/bin/bash

# Generate colorscheme
~/.local/bin/wal -i ~/Wallpapers/

# Patch background color opacity for waybar
sed -E -i "s/rgba\((.*),1.0\)/rgba(\1,0.4)/" ~/.cache/wal/colors-waybar.css

# Restart waybar
~/.config/waybar/reload-waybar.sh

# Update firefox theme
~/.local/bin/pywalfox update

# Update wallpaper
swww img $(cat ~/.cache/wal/wal) --transition-type random
