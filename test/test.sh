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

print_header_test() {
  local custom_text="$1"
  printf "\n\
**********************************************************************\n\
%s\n" "${custom_text}"
  date
  printf "\
**********************************************************************\n\n"
}

test() {
  for f in ./lib/*.sh; do
    source "$f"
  done

  print_header_test "BEGINNING OF THE TEST SCRIPT."

  sudo date

  for f in ./lib/*.sh; do
    printf "%s\n" "$f"
    source "$f"
  done

  test_lib

  print_header_test "ALL DONE. END OF THE TEST SCRIPT."
}

test "$@" | tee -a "$HOME/.ubuntu_post_install.log"
