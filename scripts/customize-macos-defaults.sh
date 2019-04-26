#!/usr/bin/env bash
#
# Customize macOS Defaults
#

# Exit immediately if a command exits with a nonzero exit status.
set -e

# Work out of a known location.
# Reference: http://stackoverflow.com/a/246128
directory_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${directory_root}"

. ./common.sh

### Customize! ###

# Close any open System Preferences panes, to prevent them from overriding settings we're about to change.
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until this scrip has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

### General UI/UX ###

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window.
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes.
sudo systemsetup -setrestartfreeze on

# Disable automatic capitalization as it's annoying when typing code.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they're annoying when typing code.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it's annoying when typing code.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they're annoying when typing code.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

### Trackpad, mouse, keyboard, Bluetooth accessories, and input ###

# Trackpad: Enable tap to click for this user and for the login screen.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Show language menu in the top right corner of the boot screen.
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Use AirDrop over every interface. This should really be the default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

### Finder ###

# Finder: Allow quitting via ⌘ + Q; doing so will also hide desktop icons.
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show status bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar.
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted.
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show the `~/Library` folder.
chflags nohidden ~/Library

# Show the `/Volumes` folder.
sudo chflags nohidden /Volumes

### Dock, Dashboard, and hot corners ###

# Speed up Mission Control animations.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't show recent applications in Dock.
defaults write com.apple.dock show-recents -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Bottom right screen corner → Start screen saver.
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

### Safari & WebKit ###

# Privacy: Don't send search queries to Apple.
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page.
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme).
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari's home page to `about:blank` for faster loading.
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening "safe" files automatically after downloading.
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari's bookmarks bar by default.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari's sidebar in Top Sites.
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari's thumbnail cache for History and Top Sites.
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Make Safari's search banners default to Contains instead of Starts With.
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari's bookmarks bar.
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari.
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views.
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking.
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct.
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill.
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites.
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows.
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable "Do Not Track".
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically.
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

### Terminal ###

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a custom theme in Terminal.app.
osascript <<EOD

tell application "Terminal"
    local allOpenedWindows
    local initialOpenedWindows
    local windowID
    set themeName to "Birds of Paradise"

    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list
       of available terminal themes (note: this will open two
       additional terminal windows). *)
    do shell script "open '$HOME/.terminal-themes/" & themeName & ".terminal'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set themeName

    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window

    repeat with windowID in allOpenedWindows
        (* Close the additional windows that were opened in order
           to add the custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)

        (* Change the theme for the initial opened terminal windows
           to remove the need to close them in order for the custom
           theme to be applied. *)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
        end if
    end repeat
end tell

EOD

# Enable Secure Keyboard Entry in Terminal.app.
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

### TextEdit ###

# Use plain text mode for new TextEdit documents.
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

### Mac App Store ###

# Enable the automatic update check.
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week.
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background.
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates.
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update.
defaults write com.apple.commerce AutoUpdate -bool true

### Messages ###

# Disable smart quotes as it's annoying for messages that contain code.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

echo "Done. Note that some of these changes require a logout/restart to take effect."
