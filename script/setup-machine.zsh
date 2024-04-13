#!/bin/zsh

if  ! command brew -v; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for zsh
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed"
    # Brewfile location
    # This assumes that the dotfiles repo has been cloned to /Users/tylermiller/dotfiles
    BREWFILE_LOCATION="/Users/tylermiller/dotfiles/Brewfile"

    # Install applications from Brewfile
    brew bundle --file "$BREWFILE_LOCATION"
fi

# Mackup should be installed by homebrew before hitting this point 
# Create a new Mackup config file
MACKUP_CONFIG_PATH="$HOME/.mackup.cfg"

echo "[storage]" > $MACKUP_CONFIG_PATH
echo "engine = icloud" >> $MACKUP_CONFIG_PATH

# Restore Mackup settings
mackup restore --force
mackup uninstall --force

# Customize macOS defaults
# Set to dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
# Set scroll as traditional instead of natural
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# set pathbar
defaults write com.apple.finder "ShowPathbar" -bool "true"
# set searchpath
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" 
# set sidebar icons size
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "3"
# show drives
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
# set sort order desktop
defaults write com.apple.finder FXArrangeGroupViewBy -string Kind
# Restart Finder
killall Finder

# Set up the dock
sh $(dirname "$0")/dock.zsh

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
read -p "Enable touch id for sudo in terminal? (y/n): " -n 1 -r
# add new line as a separator
echo ""
if [ $REPLY == "yes" ] || [ $REPLY == "y" ]; then
    echo "Enabling touch id for sudo in terminal"
    echo "A backup of the original file will be created at $SUDO_PATH.bak"
    # enable touch id
    sudo sed -i.bak '2s;^;auth       sufficient    pam_tid.so\n;' $SUDO_PATH
    echo "Touch id for sudo in terminal enabled"
else
    echo "Touch id for sudo in terminal was not enabled"
fi