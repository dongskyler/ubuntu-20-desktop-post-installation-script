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

post_install_check() {
  print_header "Post-installation checks..."

  print_header "Creating an HTML test page..."
  printf "\
  <"'!'"DOCTYPE html>\n\
  <html>\n\
    <head>\n\
      <title>Test page</title>\n\
    </head>\n\
    <body>\
      Test page\n\
    </body>\n\
  </html>\n" |
    tee "$HOME/Sites/index.html"

  print_header "Creating a PHP test page..."
  printf "<?php phpinfo(); ?>\n" |
    tee "$HOME/Sites/info.php"

  # Make sure files in $HOME/Sites are readable
  # and excutable by root (whom Nginx, PHP, etc are run as)
  chmod -R 755 "$HOME/Sites"

  print_header "Updating and upgrading one last time..."
  sudo apt-get update -y
  sudo apt-get upgrade -y

  sudo systemctl daemon-reload
  sudo systemctl reset-failed

  # Mark the end of our custom Bash profile
  print_header "Mark the end of our custom Bash profile."
  END_OF_BASHRC='# END OF CUSTOM BASHRC'
  printf "\n%s\n" "$END_OF_BASHRC" |
    tee -a "$HOME/.bashrc"

  # Copy and paste custom Bash profile configurations to Zsh profile
  print_header "Copying and pasting custom configurations from .bashrc to .zshrc..."
  awk "/$BEGINNING_OF_BASHRC/{flag=1; next} /$END_OF_BASHRC/{flag=0} flag" \
    "$HOME/.bashrc" |
    tee -a "$HOME/.zshrc"
}
