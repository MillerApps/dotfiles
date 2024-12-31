#!/bin/zsh

if  ! command brew -v; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for zsh
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed"
fi

# Install Nix
if ! command nix --help; then
    sh <(curl -L https://nixos.org/nix/install)
    else
        echo "Nix is already installed!"
fi

# Brewfile location
# This assumes that the dotfiles repo has been cloned to ~/dotfiles
BREWFILE_LOCATION="~/dotfiles/Brewfile"
# Install applications from Brewfile
brew bundle --file "$BREWFILE_LOCATION"

# Get the absolute path to the image
IMAGE_PATH="${HOME}/dotfiles/Desktop.png"

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

