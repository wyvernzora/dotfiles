#
# system/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'system-provision'
bb-task-def 'system-essentials'
bb-task-def 'system-dotfiles'


system-provision() {

  bb-task-depends 'system-essentials' 'system-dotfiles'

}


system-essentials() {

  #
  # Debian
  #
  if bb-apt?; then
    bb-apt-install build-essential git zsh

  #
  # CentOS/RHEL
  #
  elif bb-yum?; then
    bb-yum-install gcc gcc-c++ make openssl-devel git

  #
  # macOS
  #
  elif bb-brew?; then
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
    dst=".home/.$(basename "${src%.*}")"
    bb-log-debug "$src -> $dst"
    symlink "$src" "$dst"
  done

}
