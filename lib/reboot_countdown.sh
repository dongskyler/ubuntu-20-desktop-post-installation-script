#!/bin/bash
#
# Author:
# Skyler Dong <skylerdong.com>
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

reboot_countdown() {
  printf "Rebooting in 10 seconds.\nPress ANY KEY to abort.\n"

  for i in {10..1}; do
    printf "%s\n" "$i"
    read -t 1 -n 1 -r
    if [ $? == 0 ]; then
      printf "\
    Reboot aborted.\n\
    All done.\n"
      exit 0
    fi
  done

  printf "Rebooting...\n"
  for i in {3..1}; do
    printf "%s\n" "$i"
    sleep 1
  done

  sudo reboot
}
