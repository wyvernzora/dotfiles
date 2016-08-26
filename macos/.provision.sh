#
# macos/,provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#
bb-task-def 'macos-provision'
bb-task-def 'macos-defaults'
bb-task-def 'macos-apps'


macos-provision() {
  bb-task-depends 'macos-defaults' 'macos-apps'
}


macos-defaults() {

  # Show the ~/Library folder.
  bb-log-misc "Unhiding the ~/Library"
  chflags nohidden ~/Library


  # Set the Finder prefs for showing a few different volumes on the Desktop.
  bb-log-misc "Setting Finder preferences"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true


  # Set up Safari for development.
  bb-log-misc "Setting Safari preferences"
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


  # Disable guest access
  bb-log-misc "Disabling guest account"
  sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
  sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO


  # Display crash dialogs as notifications
  bb-log-misc "Setting up crash reporter notifications"
  defaults write com.apple.CrashReporter UseUNC 1

}


macos-apps() {
  bb-task-depends 'brew-packages'

  #
  # Ask for apple id
  #
  local email=$(enter_variable "AppleID email")
  local passd=$(enter_variable_hidden "AppleID password")

  mas signin "$email" "$password"

  while read app; do

    #
    # Get rid of the app name, only keep the ID
    #
    id=$(first_arg $app)

    #
    # Check if already installed
    #
    if macos-is-installed? "$id"; then

      #
      # Install the app via mas
      #
      mas install "$id"
      bb-log-misc "Installed $app"

    else

      bb-log-misc "Skipped $app"

    fi

  done < macos/apps.txt

}


function macos-is-installed? () {
  if [ -z "$(mas list | grep "$1 ")" ]; then
    return ${TRUE}
  fi
  return ${FALSE}
}
