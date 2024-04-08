#!/bin/zsh

# Script to manage the dock on macOS using defaults & dockutil
# https://github.com/kcrawford/dockutil

# set dock size
defaults write com.apple.dock "tilesize" -int "40"

# check if dockutil is installed
# this should be installed via homebrew durning 
# the setup-machine script. Which will also call this script.
if ! command -v dockutil &> /dev/null
then
    echo "dockutil could not be found"
    # however if it si not installed it will exit the script
    exit
fi

# Setup dock
# this will remove all dock items and prevent Killall Dock
dockutil --remove all --no-restart
# Start adding items
dockutil --add  /Applications/Spotify.app --position 1 --no-restart
dockutil --add  /Applications/Arc.app --position 2 --no-restart
dockutil --add  /Applications/Telegram.app --position 3 --no-restart
dockutil --add  /System/Applications/Messages.app --position 4 --no-restart
dockutil --add  /Applications/Xcode.app --position 5 --no-restart
dockutil --add  /Applications/Visual\ Studio\ Code.app --position 6 --no-restart
dockutil --add  /Applications/Zed.app --position 7 --no-restart
dockutil --add  /Applications/Warp.app --position 8 --no-restart
dockutil --add  /Applications/Obsidian.app --position 9 --no-restart
dockutil --add  /Applications/Linear.app --position 10 --no-restart
dockutil --add  /Applications/Keka.app --position 11 --no-restart

# Add folder/directory as stack
dockutil --add '~/Downloads' --view grid --display folder --allhomes --no-restart

# Restart dock to apply changes
killall Dock