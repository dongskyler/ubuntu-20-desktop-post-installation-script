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

create_new_terminal_profile() {
  local dconfdir=/org/gnome/terminal/legacy/profiles:
  local profile_ids=($(dconf list $dconfdir/ |
    grep ^: |
    sed 's/\///g' |
    sed 's/://g'))
  local profile_name="$1"
  local profile_ids_old="$(dconf read "$dconfdir"/list |
    tr -d "]")"
  local profile_id="$(uuidgen)"

  [ -z "$profile_ids_old" ] && local profile_ids_old="[" # if there's no `list` key
  [ ${#profile_ids[@]} -gt 0 ] && local delimiter=,      # if the list is empty
  dconf write $dconfdir/list \
    "${profile_ids_old}${delimiter} '$profile_id']"
  dconf write "$dconfdir/:$profile_id"/visible-name "'$profile_name'"
  printf "%s\n" "$profile_id"
}
