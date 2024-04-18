#!/bin/zsh

# Makes sure the home brew paths are always correct and avalible to the enviorment.
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Navigate to directory
cd /Users/tylermiller/dotfiles/

# Wallpaper backup
# Path to store the timestamp of the last wallpaper change
timestamp_file="/Users/tylermiller/dotfiles/last_wallpaper_change.txt"

# Create the timestamp file if it doesn't exist
if [ ! -f "$timestamp_file" ]; then
    touch "$timestamp_file"

    # Git commit for creation of last_wallpaper_change.txt file
    git add "$timestamp_file"
fi

# Get timestamp of last wallpaper change
last_change_timestamp=$(cat "$timestamp_file")

# Get path of current desktop wallpaper using osascript
wallpaper_path=$(osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)' 2>/dev/null)

backup_directory="/Users/tylermiller/dotfiles/"

if [ -z "$wallpaper_path" ]; then
    echo "No wallpaper change detected."
else
    echo "Wallpaper path: $wallpaper_path"
    # Current modification time of desktop wallpaper
    current_timestamp=$(stat -f "%m" "$wallpaper_path" 2>/dev/null)

    # Check if wallpaper has been changed recently
    if [ "$last_change_timestamp" != "$current_timestamp" ]; then
        # Copy orginal file to repo
        cp "$wallpaper_path" "$backup_directory"

        # Rename the wallpaper to Desktop.png
        new_wallpaper_path=$backup_directory/Desktop.png
        mv "$backup_directory/$(basename $wallpaper_path)" "$new_wallpaper_path"

        # Update timestamp of last wallpaper change
        echo "$current_timestamp" > "$timestamp_file"
    fi
fi

# Run the brew bundle dump
brew bundle dump --describe --force && echo "DUMPING SUCCESSFUL"

# Run Mackup
mackup backup --force
mackup uninstall --force

# Git coomit for Brewfile
if git status --porcelain | grep .; then
    git add .
    git commit -m "Auto-update"
    git push
else
    echo "No changes to commit."
fi
