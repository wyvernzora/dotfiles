#
# provision/tasks/build-essentials.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'bootstrap'

bootstrap() {

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
    if [ -z "$( xcode-select -p )" ]; then
      xcode-select --install
    fi
  fi

}
