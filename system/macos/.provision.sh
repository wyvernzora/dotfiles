#
# system/macos/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'macos-provision'
bb-task-def 'macos-defaults'


macos-provision() {

  #
  # Skip on non macOS systems
  #
  if ! is-platform? 'darwin'; then
    bb-log-info "Skipping macOS provisioning on non-macOS platform"
    return
  fi


  bb-task-depends 'macos-defaults'

}


macos-defaults() {

  # Show the ~/Library folder.
  chflags nohidden ~/Library

  # Set the Finder prefs for showing a few different volumes on the Desktop.
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # Set up Safari for development.
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Disable guest access
  sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
  sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO

  # Display crash dialogs as notifications
  defaults write com.apple.CrashReporter UseUNC 1

}
