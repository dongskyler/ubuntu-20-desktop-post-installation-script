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
    printf "This script must be run as a regular user.\n"
    exit 1
  fi

  printf "\033c"

  # Dummy command to test permissions
  cd "$HOME" || exit 1

  # Dummy sudo command to test permissions
  sudo date || exit 1

  printf "Starting...\n"

  for i in {3..1}; do
    printf "%s\n" "$i"
    sleep 1
  done
}
