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

# Load functions
for f in ./lib/*.sh; do
  source $f
done

printf "Creating some directories...\n"
mkdir "$HOME/Sites"

BEGINNING_OF_BASHRC='# BEGINNING OF CUSTOM BASHRC'
printf "\n%s\n" "$BEGINNING_OF_BASHRC" \
  >>"$HOME/.bashrc"

install_programs

printf "\033c"
printf "Configuring the system...\n"

printf "Change the default shell from Bash to Zsh...\n"
chsh -s /bin/zsh

chmod -R 755 "$HOME/Sites"

printf "Configuring terminal themes...\n"

# First, create a dummy profile.
# For some reason, if we don't, the system cannot properly
# install other profiles

dconfdir=/org/gnome/terminal/legacy/profiles:

# Create a terminal profile named Dummy
create_new_terminal_profile Dummy

printf "Installing terminal profile 'Earthsong'...\n"
printf "36\n" | bash -c "$(wget -qO- https://git.io/vQgMr)"

printf "Set 'Earthsong' as the default profile...\n"
set_default_terminal_profile Earthsong

printf "\033c"
printf "Adding a few shell aliases...\n"
add_aliases

printf "Pinning favorite apps to dash...\n"
set_favorite_apps

printf "\033c"
printf "Updating and upgrading one last time...\n"
sudo apt update
sudo apt upgrade -y

END_OF_BASHRC='# END OF CUSTOM BASHRC'
printf "\n%s\n" "$END_OF_BASHRC" \
  >>"$HOME/.bashrc"

printf "Copying and pasting custom configurations from .bashrc to .zshrc..."
awk "/$BEGINNING_OF_BASHRC/{flag=1; next} /$END_OF_BASHRC/{flag=0} flag" \
  "$HOME/.bashrc" >>"$HOME/.zshrc"

printf "\033c"
printf "Cleaning up...\n"
clean_up_downloaded_files

printf "\033c"
printf \
  "************************************************************\n\
All done!\n\
************************************************************\n"

printf "Rebooting in 10 seconds.\nPress ANY KEY to abort.\n"

for i in {10..1}; do
  printf "%s\n" "$i"
  read -t 1 -n 1 -r
  if [ $? == 0 ]; then
    printf "Reboot aborted.\nAll done!\n"
    exit 0
  fi
done

printf "Rebooting...\n"
for i in {3..1}; do
  printf "%s\n" "$i"
  sleep 1
done

sudo reboot
