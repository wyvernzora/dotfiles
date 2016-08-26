#
# macos/,provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#
bb-task-def 'macos-provision'
bb-task-def 'macos-preferences'
bb-task-def 'macos-defaults'
bb-task-def 'macos-apps'


macos-provision() {
  bb-task-depends 'macos-preferences' 'macos-defaults' 'macos-apps'
}


macos-preferences() {

  for pref in $DOT_ROOT/macos/preferences/*; do
    src="${pref}"
    dst="${HOME}/Library/Preferences/$(basename "${pref}")"
    symlink "$src" "$dst"
  done

}


macos-defaults() {

  bb-log-misc "Setting up general defaults"
  source macos/defaults/general.sh

  bb-log-misc "Setting up SSD-specific defaults"
  source macos/defaults/ssd.sh

  bb-log-misc "Setting up peripherals defaults"
  source macos/defaults/peripherals.sh

  bb-log-misc "Setting up screen defaults"
  source macos/defaults/screen.sh

  bb-log-misc "Setting up Finder defaults"
  source macos/defaults/finder.sh

  bb-log-misc "Setting up Dock defaults"
  source macos/defaults/dock.sh

  bb-log-misc "Setting up Safari defaults"
  source macos/defaults/safari.sh

  bb-log-misc "Setting up Spotlight defaults"
  source macos/defaults/spotlight.sh

  bb-log-misc "Setting up AppStore defaults"
  source macos/defaults/app-store.sh

  bb-log-misc "Setting up app defaults"
  source macos/defaults/apps.sh

  bb-log-misc "Disabling guest account"
  sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
  sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO

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
