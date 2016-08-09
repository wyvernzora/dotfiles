#
# nodejs/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


bb-task-def 'nodejs-provision'
bb-task-def 'nodejs-npmrc'


nodejs-provision() {
  bb-task-depends 'nodejs-npmrc'
}


nodejs-npmrc() {
  if ! [ -f "nodejs/npmrc.symlink" ]; then
    cp "nodejs/npmrc.symlink.example" "nodejs/npmrc.symlink"
  fi
}
