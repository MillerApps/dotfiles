#!/bin/zsh

# Navigate to directory
cd /Users/tylermiller/New-Machine/

# Wallpaper backup
# Path to store the timestamp of the last wallpaper change
timestamp_file="/Users/tylermiller/New-Machine/last_wallpaper_change.txt"

# Create the timestamp file if it doesn't exist
if [ ! -f "$timestamp_file" ]; then
    touch "$timestamp_file"

    # Git commit for creation of last_wallpaper_change.txt file
    /opt/homebrew/bin/git add "$timestamp_file"
    /opt/homebrew/bin/git commit -m "Create last_wallpaper_change.txt for tracking wallpaper changes"
    /opt/homebrew/bin/git push
fi

# Get timestamp of last wallpaper change
last_change_timestamp=$(cat "$timestamp_file")

# Get path of current desktop wallpaper using osascript
wallpaper_path=$(osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)')
echo "Wallpaper path: $wallpaper_path"

# Current modification time of desktop wallpaper
current_timestamp=$(stat -f "%m" "$wallpaper_path" 2>/dev/null)

# Check if wallpaper has been changed recently
if [ "$last_change_timestamp" != "$current_timestamp" ]; then
    # Rename the wallpaper to Desktop.png
    new_wallpaper_path=$(dirname "$wallpaper_path")/Desktop.png
    mv "$wallpaper_path" "$new_wallpaper_path"

    # Copy the renamed desktop wallpaper to your backup repository
    cp "$new_wallpaper_path" "/Users/tylermiller/New-Machine/"

    # Update timestamp of last wallpaper change
    echo "$current_timestamp" > "$timestamp_file"

    # Git commit for wallpaper change
    /opt/homebrew/bin/git add Desktop.png
    /opt/homebrew/bin/git commit -m "Update desktop wallpaper"
    /opt/homebrew/bin/git push
fi

# Update brew formulas and casks
/opt/homebrew/bin/brew upgrade --cask --greedy

# Brew cleanup
/opt/homebrew/bin/brew cleanup --prune=all

# Run the brew bundle dump
/opt/homebrew/bin/brew bundle dump --describe --force

# Run Mackup
/opt/homebrew/bin/mackup backup --force
/opt/homebrew/bin/mackup uninstall --force

# Git coomit for Brewfile
/opt/homebrew/bin/git add Brewfile
/opt/homebrew/bin/git commit -m "Auto-update Brewfile"
/opt/homebrew/bin/git push
