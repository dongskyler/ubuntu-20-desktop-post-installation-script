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

set_default_terminal_profile() {
  local dconfdir=/org/gnome/terminal/legacy/profiles:
  local profile_ids=($(dconf list $dconfdir/ |
    grep ^: |
    sed 's/\///g' |
    sed 's/://g'))
  local profile_name="$1"

  for id in "${profile_ids[@]}"; do
    if [[ $(dconf read "${dconfdir}/:${id}/visible-name") == \
    "'""$profile_name""'" ]]; then
      gsettings set org.gnome.Terminal.ProfilesList default ${id}
      break
    fi
  done
}
