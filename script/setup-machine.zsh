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

