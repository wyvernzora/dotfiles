#
# system/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'system-provision'
bb-task-def 'system-essentials'
bb-task-def 'system-dotfiles'
bb-task-def 'system-zsh'


system-provision() {

  bb-task-depends 'system-essentials' 'system-dotfiles'

}


system-essentials() {

  #
  # Debian
  #
  if is-platform? 'debian'; then
    bb-apt-install $( tr '\n' '' < system/essentials.debian.txt )


  #
  # CentOS/RHEL
  #
  elif is-platform? 'centos'; then
    bb-yum-install $( tr '\n' '' < system/essentials.centos.txt )


  #
  # macOS
  #
  elif is-platform? 'darwin'; then
    if [ -z "$( "xcode-select" -p )" ]; then
      xcode-select --install
    fi

  fi

}


system-dotfiles() {

  bb-task-depends 'git-gitconfig' 'nodejs-npmrc'

  #
  # Symlink all *.symlink files into home directory
  #
  for src in $(find -H '.' -maxdepth 2 -name '*.symlink'); do
    src="$(pwd)/$src"
    dst="$HOME/.$(basename "${src%.*}")"
    symlink "$src" "$dst"
  done

}


system-zsh() {
  bb-task-depends 'system-essentials' 'brew-provision'

  chsh -s $(which zsh);
}
