#
# macos/defaults/apps.sh
#
# @author  Matias Bynens <https://mathiasbynens.be>
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Time Machine
#

#
# Prevent Time Machine from prompting to use new hard drives as backup volume
#
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


#
# Disable local Time Machine backups
#
# hash tmutil &> /dev/null && sudo tmutil disablelocal



#
# Activity Monitor
#


#
# Show the main window when launching Activity Monitor
#
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true


#
# Visualize CPU usage in the Activity Monitor Dock icon
#
defaults write com.apple.ActivityMonitor IconType -int 5


#
# Show all processes in Activity Monitor
#
defaults write com.apple.ActivityMonitor ShowCategory -int 0


#
# Sort Activity Monitor results by CPU usage
#
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0




#
# Contacts, dashboard, calendar, TextEdit, Disk Utility
#


#
# Enable the debug menu in Address Book
#
defaults write com.apple.addressbook ABShowDebugMenu -bool true


#
# Enable Dashboard dev mode (allows keeping widgets on the desktop)
#
# defaults write com.apple.dashboard devmode -bool true


#
# Use plain text mode for new TextEdit documents
#
defaults write com.apple.TextEdit RichText -int 0


#
# Open and save files as UTF-8 in TextEdit
#
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4


#
# Enable the debug menu in Disk Utility
#
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


#
# Auto-play videos when opened with QuickTime Player
#
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true




#
# Photos
#


#
# Prevent Photos from opening automatically when devices are plugged in
#
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true




#
# Messages
#


#
# Disable automatic emoji substitution (i.e. use plain text smileys)
#
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false


#
# Disable smart quotes as it’s annoying for messages that contain code
#
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false


#
# Disable continuous spell checking
#
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false



#
# Chrome
#


#
# Allow installing user scripts via GitHub Gist or Userscripts.org
#
defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/"


#
# Disable the all too sensitive backswipe on trackpads
#
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false


#
# Disable the all too sensitive backswipe on Magic Mouse
#
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false


#
# Use the system-native print preview dialog
#
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true


#
# Expand the print dialog by default
#
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true




#
# Transmission
#


#
# Use `~/Downloads/Incomplete` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"


#
# Don’t prompt for confirmation before downloading
#
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false


#
# Trash original torrent files
#
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true


#
# Hide the donate message
#
defaults write org.m0k.transmission WarningDonate -bool false


#
# Hide the legal disclaimer
#
defaults write org.m0k.transmission WarningLegal -bool false

#
# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
#
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
