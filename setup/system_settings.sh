#!/bin/sh
###############################################################################
echo "==> General UI/UX"
###############################################################################

echo "--> Hiding the Time Machine, Volume, User, and Bluetooth icons"
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
    # "/System/Library/CoreServices/Menu Extras/Volume.menu"
    #"/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu"

echo "--> Hiding spotlight icon"
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# to undo
# sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

echo "--> Disabling OS X Gate Keeper"
echo "    (You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "--> Disabling OS X Crash Reporter"
sudo defaults write com.apple.CrashReporter DialogType none
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

echo "--> Increasing the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "--> Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "--> Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
echo "--> Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# I like my terminal resume too much...
#echo ""
#echo "Disabling system-wide resume"
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

echo "--> Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "--> Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "--> Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# echo ""
# echo "Never go into computer sleep mode"
# systemsetup -setcomputersleep Off > /dev/null

echo "--> Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "--> Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
echo "==> Trackpad, mouse, keyboard, bluetooth"
###############################################################################

echo "--> Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "--> Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "--> Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "--> Setting a blazingly fast keyboard repeat rate (ain't nobody got time fo special chars while coding!)"
defaults write NSGlobalDomain KeyRepeat -int 0

echo "--> Disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "--> Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo "--> Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
echo "==> Screen"
###############################################################################

echo "--> Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "--> Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "--> Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


###############################################################################
echo "==> Finder"
###############################################################################

echo "--> Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "--> Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "--> Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "--> Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "--> Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "--> Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "--> Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo "--> Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "--> Disabling disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "--> Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


echo "--> Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "--> Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "--> Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"


echo "--> Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "--> Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true

###############################################################################
echo "==> Dock & Mission Control"
###############################################################################

echo "--> Wipe all (default) app icons from the Dock"
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

echo "--> Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo "--> Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "--> Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "--> Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

echo "--> Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

echo "--> Wipe all (default) app icons from the Dock"
# This is only really useful when setting up a new Mac, or if you don't use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

echo "--> Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "--> Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

echo "--> Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "--> Don't group windows by application in Mission Control"
echo "--> (i.e. use the old Expose behavior instead)"
defaults write com.apple.dock expose-group-by-app -bool false

echo "--> Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "--> Don't show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "--> Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false




###############################################################################
echo "==> Safari & WebKit"
###############################################################################

echo "--> Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "--> Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "--> Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "--> Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "--> Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "--> Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "--> Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "--> Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo "--> Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


###############################################################################
echo "==> Mail"
###############################################################################

echo "--> Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


###############################################################################
echo "==> Terminal"
###############################################################################

echo "--> Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4

# echo ""
# echo "Terminal.app: setting the Pro theme by default"
# defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
# defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

###############################################################################
echo "==> Time Machine"
###############################################################################

echo "--> Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "--> Disabling local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal


###############################################################################
echo "==> Messages"
###############################################################################

echo "--> Disable automatic emoji substitution (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

echo "--> Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "--> Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
echo "==> Activity Monitor"
###############################################################################

echo "--> Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo "--> Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo "--> Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "--> Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


###############################################################################
echo "==> Personal Additions"
###############################################################################

# echo ""
# echo "Disable hibernation (speeds up entering sleep mode)"
# sudo pmset -a hibernatemode 0

# echo ""
# echo "Remove the sleep image file to save disk space"
# sudo rm /Private/var/vm/sleepimage
# echo "Creating a zero-byte file insteadâ€¦"
# sudo touch /Private/var/vm/sleepimage
# echo "â€¦and make sure it can't be rewritten"
# sudo chflags uchg /Private/var/vm/sleepimage

echo "--> Disable the sudden motion sensor as it's not useful for SSDs"
sudo pmset -a sms 0

echo "--> Speeding up wake from sleep to 12 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 43200 

# echo ""
# echo "Disable computer sleep and stop the display from shutting off"
# sudo pmset -a sleep 0
# sudo pmset -a displaysleep 0

echo "--> Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

echo "--> Use the system-native print preview dialog in Chrome"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true


echo "--> Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

###############################################################################
# Kill affected applications
###############################################################################

echo "==> Done!"