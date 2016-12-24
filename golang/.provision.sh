#
# golang/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


bb-task-def 'golang-provision'
bb-task-def 'golang-install'


golang-provision() {
  bb-task-depends 'golang-install'
}


golang-install() {

  if ! bb-exe? "go"; then
    brew install go
    bb-log-misc "Installed go"
  fi

}
