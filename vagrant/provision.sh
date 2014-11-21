#!/bin/bash
#
# Title           : Vagrant provision
# Description     : Install Emacs for emacs-travis tests
# ------------------------------------------------------

TOKEN=$1
# echo "Token : $TOKEN"

CASK_VERSION='0.6.0'

ppa () {
    sudo apt-add-repository -y "$1"
}

apt_update () {
    sudo apt-get update -qq
}

apt () {
    sudo apt-get install -yy "$@"
}

# Silence debconf
export DEBIAN_FRONTEND='noninteractive'

# Bring in the necessary PPAs
ppa ppa:ubuntu-elisp/ppa
apt_update

# Install Emacs 24.x and Emacs snapshot
apt emacs24 emacs24-el emacs24-common-non-dfsg \
    emacs-snapshot emacs-snapshot-el

# Install Cask for Emacs dependency management
CASK_DIR=/opt/cask-$CASK_VERSION
if ! [ -d "$CASK_DIR" -a -x "/$CASK_DIR/bin/cask" ]; then
  sudo rm -rf "$CASK_DIR"
  wget -O - https://github.com/cask/cask/archive/v$CASK_VERSION.tar.gz | sudo tar xz -C /opt
  sudo ln -fs "$CASK_DIR/bin/cask" /usr/local/bin
fi

echo "#!/bin/bash" > /tmp/.emacs-travis.rc
echo "" >> /tmp/.emacs-travis.rc
echo "export TRAVIS_TOKEN=\"$TOKEN\"" >> /tmp/.emacs-travis.rc
