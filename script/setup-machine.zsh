#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for zsh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Prompt for Brewfile location
echo "Enter the path to your Brewfile:"
read BREWFILE_LOCATION

# Install applications from Brewfile
cd $BREWFILE_LOCATION && brew bundle

# Create a new Mackup config file
MACKUP_CONFIG_PATH="$HOME/.mackup.cfg"

echo "[storage]" > $MACKUP_CONFIG_PATH
echo "engine = icloud" >> $MACKUP_CONFIG_PATH

# Restore Mackup settings
mackup restore --force
mackup uninstall --force

# Set scroll as traditional instead of natural
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false && killall Finder

# Set to dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Get the absolute path to the image
IMAGE_PATH="${HOME}/New-Machine/Desktop.png"

# AppleScript command to set the desktop background
osascript <<EOF
tell application "System Events"
    set desktopCount to count of desktops
    repeat with desktopNumber from 1 to desktopCount
        tell desktop desktopNumber
            set picture to "$IMAGE_PATH"
        end tell
    end repeat
end tell
EOF
