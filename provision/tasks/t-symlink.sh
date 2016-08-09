#
# provision/tasks/t-symlink.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 't-symlink'

t-symlink() {

  #
  # We need to complete setting up .gitconfig and .npmrc
  #
  bb-task-depends 't-gitconfig' 't-npmrc'


  #
  # Symlink all *.symlink files into home directory
  #
  for src in $(find -H '.' -maxdepth 2 -name '*.symlink'); do
    dst="$HOME/.$(basename "${src%.*}")"
    echo $src $dst # TODO enable later
  done

}
