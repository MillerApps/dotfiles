#!/bin/zsh

# Navigate to directory
cd /Users/tylermiller/New-Machine/

# Run the brew bundle dump
brew bundle dump --force

# Run Mackup
mackup backup --force
mackup uninstall --force

# Git
git add Brewfile
git commit -m "Auto-update Brewfile"
git push
