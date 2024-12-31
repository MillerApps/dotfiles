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

# Set up touch id sudo for terminal
SUDO_PATH="/private/etc/pam.d/sudo" # path to the sudo file, this correct on newer macos versions
# check if user wants to enable touch id
echo "Enable touch id for sudo in terminal? (y/n): " REPLY
read REPLY
# add new line as a separator
echo ""
# Uses regex to match y or Y or yes or Yes
if [[ $REPLY =~ ^[Yy]es$ ]] || [[ $REPLY =~ ^[Yy]$ ]]; then 
    echo "Enabling touch id for sudo in terminal"
    echo "A backup of the original file will be created at $SUDO_PATH.bak"
    # enable touch id
    sudo sed -i.bak '2s;^;auth       sufficient    pam_tid.so\n;' $SUDO_PATH
    echo "Touch id for sudo in terminal enabled"
else
    echo "Touch id for sudo in terminal was not enabled"
fi
