#
# git/.provision.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#

bb-task-def 'git-provision'
bb-task-def 'git-gitconfig'
bb-task-def 'git-install'


git-provision() {
  bb-task-depends 'git-gitconfig' 'git-install'
}


git-install() {

  #
  # Debian
  #
  if is-platform? 'debian'; then
    bb-apt-install git


  #
  # CentOS/RHEL
  #
  elif is-platform? 'centos'; then
    bb-yum-install git


  #
  # macOS
  #
  elif is-platform? 'darwin'; then
    bb-brew-install git


  fi

}


git-gitconfig() {

  if ! [ -f "git/gitconfig.symlink" ]; then

    # Determine type of credential cache to use
    local git_credential='cache'
    if is-platform? 'darwin'; then
      git_credential='osxkeychain'
    fi

    # Ask for basic git info
    local git_authorname=$(enter_variable "What is your GitHub author name?" "$(whoami)")
    local git_authoremail=$(enter_variable "What is your GitHub author email?" "$(whoami)@gmail.com")

    # Generate the actual gitconfig.symlink file
    sed -e "s/AUTHORNAME/$git_authorname/g" \
        -e "s/AUTHOREMAIL/$git_authoremail/g" \
        -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
        git/gitconfig.symlink.example > git/gitconfig.symlink

  fi

}
