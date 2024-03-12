#!/bin/zsh

# Navigate to directory
cd /Users/tylermiller/New-Machine/

# Run the brew bundle dump
/opt/homebrew/bin/brew bundle dump --describe --force

# Run Mackup
/opt/homebrew/bin/mackup backup --force
/opt/homebrew/bin/mackup uninstall --force

# Git
/opt/homebrew/bin/git add Brewfile
/opt/homebrew/bin/git commit -m "Auto-update Brewfile"
/opt/homebrew/bin/git push
