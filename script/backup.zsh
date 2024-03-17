#!/bin/zsh

# Navigate to directory
cd /Users/tylermiller/New-Machine/

# Update brew formulas and casks
/opt/homebrew/bin/brew update && /opt/homebrew/bin/brew upgrade
/opt/homebrew/bin/brew upgrade --cask --greedy

# Brew cleanup
/opt/homebrew/bin/brew cleanup --prune=all

# Run the brew bundle dump
/opt/homebrew/bin/brew bundle dump --describe --force

# Run Mackup
/opt/homebrew/bin/mackup backup --force
/opt/homebrew/bin/mackup uninstall --force

# Git
/opt/homebrew/bin/git add Brewfile
/opt/homebrew/bin/git commit -m "Auto-update Brewfile"
/opt/homebrew/bin/git push
