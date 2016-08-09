#
# zsh/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'zsh-provision'
bb-task-def 'zsh-install'
bb-task-def 'zsh-antibody'
bb-task-def 'zsh-antibody-bundles'


zsh-provision() {
  bb-task-depends 'zsh-install' 'zsh-antibody' 'zsh-antibody-bundles'
}


zsh-install() {

  #
  # Debian
  #
  if is-platform? 'debian'; then
    bb-apt-install zsh


  #
  # CentOS/RHEL
  #
  elif is-platform? 'centos'; then
    bb-yum-install zsh


  #
  # macOS
  #
  elif is-platform? 'darwin'; then
    bb-brew-install zsh


  fi

}


zsh-antibody() {
  bb-task-depends 'brew-install' 'zsh-install'

  if bb-brew?; then
    brew tap getantibody/homebrew-antibody > /dev/null
    brew install antibody > /dev/null

  else
    antibody_installer="https://raw.githubusercontent.com/getantibody/installer/master/install"
    curl -s "${antibody_installer}" | bash -s > /dev/null

  fi

  bb-log-misc "Installed antibody"
}


zsh-antibody-bundles() {
  bb-task-depends 'zsh-antibody'

  antibody bundle < zsh/bundles.txt > /dev/null
}
