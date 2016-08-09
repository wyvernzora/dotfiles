#
# provision/util/platform.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


function is-platform? () {

  local platform=$(uname | tr "[:upper:]" "[:lower:]")

  # Linux platforms...we need to tell debian from rhel
  if [ "$platform" = "linux" ]; then

    # yum -> rhel
    if bb-yum?; then
      platform="centos"
    fi

    # apt-get -> debian
    if bb-apt?; then
      platform="debian"
    fi

  fi

  # Compare with the supplied parameter
  local target=$(echo "$1" | tr "[:upper:]" "[:lower:]")
  if [ "$target" = "$platform" ]; then
    return ${TRUE}
  fi
  return ${FALSE}
}
