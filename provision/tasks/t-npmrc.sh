#
# provision/tasks/t-npmrc.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 't-npmrc'

t-npmrc() {

  if ! [ -f "nodejs/npmrc.symlink" ]; then
    cp "nodejs/npmrc.symlink.example" "nodejs/npmrc.symlink"
  fi

}
