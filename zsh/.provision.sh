#
# zsh/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'zsh-provision'
bb-task-def 'zsh-install'


zsh-provision() {
  bb-task-depends 'zsh-install'
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
