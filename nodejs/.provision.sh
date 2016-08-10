#
# nodejs/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


bb-task-def 'nodejs-provision'
bb-task-def 'nodejs-install'
bb-task-def 'nodejs-npmrc'
bb-task-def 'nodejs-npmi'


nodejs-provision() {
  bb-task-depends 'nodejs-npmrc' 'nodejs-install' 'nodejs-npmi'
}


nodejs-install() {

  if ! bb-exe? "n"; then
    curl -L http://git.io/n-install | bash -s -- -n -y &> /dev/null
    bb-log-misc "Installed n"
  fi

  # Load environment variables required by n
  source nodejs/.onload.sh

  # Install latest LTS release of Node.js
  n lts --quiet &> /dev/null

  bb-log-misc "Installed latest LTS release of Node.js"

}


nodejs-npmrc() {
  if ! [ -f "nodejs/npmrc.symlink" ]; then
    cp "nodejs/npmrc.symlink.example" "nodejs/npmrc.symlink"
  fi
}


nodejs-npmi() {

  bb-task-depends 'nodejs-npmrc' 'nodejs-install'

  npm install --global npm --no-progress --silent > /dev/null;

  while read package; do
    npm install --global "$package" --no-progress --silent > /dev/null;
    bb-log-misc "Installed ${package}"
  done < nodejs/packages.txt;

}
