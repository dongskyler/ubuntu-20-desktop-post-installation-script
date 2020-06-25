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

main() {
  printf "Beginning of test.sh\n"

  for f in ./lib/*.sh; do
    printf "%s\n" "$f"
    source $f
  done

  test_lib
  
  printf "End of test.sh\n"
}

main "$@"
