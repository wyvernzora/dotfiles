#
# atom/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'atom-provision'
bb-task-def 'atom-install'
bb-task-def 'atom-apmi'


atom-provision() {

  #
  # Skip on non macOS platforms
  #
  if ! is-platform? 'darwin'; then
    bb-log-misc "Skipping atom provisioning on non macOS platform"
    return
  fi

  bb-task-depends 'atom-install' 'atom-apmi'
}


atom-install() {
  bb-task-depends 'brew-taps'

  if ! bb-exe? 'apm'; then
    brew cask install atom > /dev/null
    bb-log-misc "Installed atom"
  else
    bb-log-misc "Atom already installed"
  fi

}


atom-apmi() {
  bb-task-depends 'atom-install' 'system-dotfiles'

  while read package; do

    if [ -d "atom.symlink/packages/$package" ]; then
      bb-log-misc "Skipped $package"
      continue
    fi

    apm install "$package" > /dev/null
    bb-log-misc "Installed $package"
  done < "atom.symlink/packages.txt";

}
