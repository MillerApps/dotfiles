#!/bin/zsh

# setup backup_directory path
BASE_BACKUP_DIR=~/dotfiles
BREW_BACKUP_DIR=$BASE_BACKUP_DIR/brew
WALLPAPER_BACKUP_DIR=$BASE_BACKUP_DIR/wallpaper

# Create directory if needed otherwise, silently exit without error
mkdir -p "$WALLPAPER_BACKUP_DIR" "$BREW_BACKUP_DIR"

# Makes sure the home brew paths are always correct and avalible to the enviorment.
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Navigate to directory
cd "$BASE_BACKUP_DIR" || exit 1

# Ensure the latest from remote
git pull

# Wallpaper backup
# Path to store the timestamp of the last wallpaper change
timestamp_file="$WALLPAPER_BACKUP_DIR/last_wallpaper_change.txt"

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

if [ -z "$wallpaper_path" ]; then
    echo "No wallpaper change detected."
else
    echo "Wallpaper path: $wallpaper_path"
    # Current modification time of desktop wallpaper
    current_timestamp=$(stat -f "%m" "$wallpaper_path" 2>/dev/null)

    # Check if wallpaper has been changed recently
    if [ "$last_change_timestamp" != "$current_timestamp" ]; then
        # Copy orginal file to repo
        cp "$wallpaper_path" "$WALLPAPER_BACKUP_DIR"

        # Rename the wallpaper to Desktop.png
        new_wallpaper_path=$WALLPAPER_BACKUP_DIR/Desktop.png
        mv "$WALLPAPER_BACKUP_DIR/$(basename $wallpaper_path)" "$new_wallpaper_path"

        # Update timestamp of last wallpaper change
        echo "$current_timestamp" > "$timestamp_file"
    fi
fi

# Run the brew bundle dump
cd "$BREW_BACKUP_DIR" && brew bundle dump --describe --force --no-restart && echo "DUMPING SUCCESSFUL"

# Git commit for Brewfile
cd "$BASE_BACKUP_DIR" || exit 1
if git status --porcelain | grep .; then
    git add .
    git commit -m "chore: Auto-update"
    git push
else
    echo "No changes to commit."
fi
