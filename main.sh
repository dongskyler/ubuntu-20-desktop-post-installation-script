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
    source $f
  done

  print_header "Beginning of installation script."

  # Do pre-install checks
  pre_install_check

  # Create some directories
  print_header "Creating some directories..."

  # localhost:8080 will be rooted here
  mkdir "$HOME/Sites"

  # Mark the beginning of our custom Bash profile
  BEGINNING_OF_BASHRC='# BEGINNING OF CUSTOM BASHRC'
  printf "\n%s\n" "$BEGINNING_OF_BASHRC" \
    >>"$HOME/.bashrc"

  # Install programs
  install_programs

  # Configurate the system
  print_header "Configuring the system..."

  # Make sure files in $HOME/Sites are readable
  # and excutable by root (whom Nginx, PHP, etc are run as)
  chmod -R 755 "$HOME/Sites"

  # Change the default shell from Bash to Zsh
  printf "Change the default shell from Bash to Zsh...\n"
  chsh -s /bin/zsh

  # Configure terminal profiles
  printf "Configuring terminal profiles...\n"

  # First, create a dummy profile.
  # For some reason, if we don't, the system cannot properly
  # install other profiles
  create_new_terminal_profile Dummy

  # Install terminal profile 'Earthsong' and set it as default
  printf "Installing terminal profile 'Earthsong'...\n"
  printf "36\n" |
    bash -c "$(wget -qO- https://git.io/vQgMr)"
  printf "Set 'Earthsong' as the default profile...\n"
  set_default_terminal_profile Earthsong

  # Add shell aliases
  print_header "Adding a few shell aliases..."
  add_aliases

  # Set favoriate apps to dash
  print_header "Pinning favorite apps to dash..."
  set_favorite_apps

  # Update and upgrade one last time
  print_header "Updating and upgrading one last time..."
  sudo apt-get update -y
  sudo apt-get upgrade -y

  # Mark the end of our custom Bash profile
  END_OF_BASHRC='# END OF CUSTOM BASHRC'
  printf "\n%s\n" "$END_OF_BASHRC" \
    >>"$HOME/.bashrc"

  # Copy and paste custom Bash profile configurations to Zsh profile
  printf "Copying and pasting custom configurations from .bashrc to .zshrc..."
  awk "/$BEGINNING_OF_BASHRC/{flag=1; next} /$END_OF_BASHRC/{flag=0} flag" \
    "$HOME/.bashrc" |
    tee -a "$HOME/.zshrc"

  # Clean up
  print_header "Cleaning up..."
  clean_up

  # Notify user of the end of this script
  print_header "All done. End of installation script."

  # Reboot the computer
  reboot_countdown
}

main "$@" | tee -a "$HOME/.ubuntu_post_install.log"
