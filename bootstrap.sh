#!/bin/bash
# TODO: Setting return errors

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi
readonly REPO="https://github.com/cristianarbe/dot-files.git"
readonly PIA_EXISTS=$(find /etc/openvpn/ -name "pia*" | wc -l)
readonly PIA_URL="https://www.privateinternetaccess.com/installer/pia-nm.sh"
readonly MEGASYNC_URL="https://mega.nz/linux/MEGAsync/Fedora_29/x86_64/megasync-Fedora_29.x86_64.rpm"

dot_files(){
  if [[ -f /home/${SUDO_USER}/README.md ]]; then
    echo "Dot files are already set"
  else
    echo "###### Setting up dot files"
    cd  /tmp/ || exit
    git clone "$REPO"
    cd dot-files || exit
    shopt -s dotglob
    mv /tmp/dot-files/* "/home/${SUDO_USER}/"
  fi
  mkdir -p /usr/share/themes/noborders/xfwm4/
  touch /usr/share/themes/noborders/xfwm4/themerc
}

install_dnf(){
  echo "###### Installing dnf packages"
  install_packages=$(cat "config/install_packages.txt")
  dnf install "$install_packages" -y

  uninstall_packages=$(cat "config/uninstall_packages.txt")
  dnf remove "$uninstall_packages" -y

  dnf upgrade -y
}

extra_packes(){
  if [[ $PIA_EXISTS -eq 0 ]]; then
    cd /tmp/ || exit
    echo "###### Installing PIA"
    wget "$PIA_URL"
    bash pia-nm.sh
  else
    echo "PIA is already installed"
  fi

  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  cd /tmp/ || exit
  if [[ -f /bin/megasync ]]; then
    echo "MEGASync is already installed"
  else
    echo "##### Installing MEGASync"
    wget $MEGASYNC_URL
    local file
    file=$(find . -name "megasync-Fedora*")
    dnf install "$file"
  fi
}

function main(){

  clear
  echo "1. Dot files install"
  echo "===================="
  echo ""
  echo "This installs my personal dot files"
  read -rp "Do you want to proceed? [y/N]: " response
  if [[ $response == "y" ]]; then
    dot_files
  fi

  echo ""
  echo "2. Packages install"
  echo "==================="
  echo ""
  echo "This installs the packages that I use"
  read -rp "Do you want to proceed? [y/N]: " response
  if [[ $response == "y" ]]; then
    install_dnf
  fi

  echo ""
  echo "3. Extra packages"
  echo "===================="
  echo ""
  echo "This installs packages that are not in dnf. This includes PIA, \
    MegaSync and vim plug"
      read -rp "Do you want to proceed? [y/N]: " response
      if [[ $response == "y" ]]; then
        extra_packages
      fi

      echo ""
      echo "4. Installation finished"
      echo "================="
      echo ""
      echo "This step will reboot the system"
      read -rp "Do you want to proceed? [y/N]: " response
      if [[ $response = "y" ]]; then
        reboot
      else
        echo "All done!"
      fi
    }

  main
