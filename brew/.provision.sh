#
# brew/provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

#
# provision/tasks/t-brew-pkgs.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'brew-provision'


brew-provision() {


  #
  # Skip this step on platforms other than macOS
  #
  if ! is-platform? 'darwin'; then
    bb-log-info "Not running on macOS, skipping brew packages"
    return
  fi


  #
  # Fail if brew is unavailable (unlikely)
  #
  if ! bb-brew?; then
    bb-log-fail "Homebrew is not available"
  fi


  #
  # Install brew taps
  #
  while read tap; do
    if ! bb-brew-repo? "$tap"; then
      brew tap "$tap" &> /dev/null;
      bb-log-misc "Tapped ${tap}"
    else
      bb-log-misc "Skipped ${tap}"
    fi
  done < brew/taps.txt;


  #
  # Install brew packages
  #
  while read pkg; do

    #
    # Get the actual package name
    #
    name=$(first_arg $pkg)

    if ! bb-brew-package? "$name"; then
      #
      # No quotes around $pkg here since packages may have additional arguments
      #
      brew install $pkg &> /dev/null
      bb-log-misc "Installed ${pkg}"
    else
      bb-log-misc "Skipped ${pkg}"
    fi
  done < brew/packages.txt;


  #
  # TODO Install cask packages
  #


}
