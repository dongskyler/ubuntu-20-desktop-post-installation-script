#!/bin/bash
#
# Author:
# Skyler Dong <skyler@skylerdong.com>
#
# Description:
# Script for installing essential programs on a freshly installed
# Ubuntu Desktop 20 (Focal Fossa)
#
# Repository:
# https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script
#
# Copyright (c) 2020 Skyler Dong.
#
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.
#

pre_install_check() {
  # Check user permission
  if [[ $EUID -eq 0 ]]; then
    printf "Error"'!'" This script must be run as a regular user.\n"
    exit 1
  fi

  # Check if we have access to home directory
  cd "$HOME" || exit 1

  # Check sudo permission
  # Also output the datetime as the first line of the log
  sudo -v || exit 1

}
