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

main() {
  # Load functions from lib
  for f in ./lib/*.sh; do
    source "$f"
  done

  print_header "BEGINNING OF INSTALLATION SCRIPT."

  # Configuring the system before installing programs
  pre_install_config

  # Uninstall programs
  uninstall_programs

  # Install programs
  install_programs

  # Add shell aliases
  add_aliases

  # Configure terminal profiles
  print_header "Configuring terminal profiles..."
  # First, create a dummy profile. For some reason,
  # if we don't, the system cannot properly install profiles
  printf "Create a dummy terminal profile 'Dummy'...\n"
  create_new_terminal_profile Dummy

  # Install terminal profile 'Earthsong'
  printf "Installing terminal profile 'Earthsong'...\n"
  printf "36\n" |
    bash -c "$(wget -qO- https://git.io/vQgMr)"

  # Set profile'Earthsong' as default
  printf "Set 'Earthsong' as the default profile...\n"
  set_default_terminal_profile Earthsong

  # Set favoriate apps to dash
  set_favorite_apps

  # Configuring the system after installing programs
  post_install_config

  # Clean up
  clean_up

  # Mark the end of this script
  print_header "ALL DONE. END OF INSTALLATION SCRIPT."

  # Reboot the computer
  reboot_countdown
}

main "$@" |
  tee -a "$HOME/.ubuntu_post_install.log"
