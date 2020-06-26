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

uninstall_programs() {
  print_header "Updating apt-get package list..."
  sudo apt-get update -y

  print_header "Uninstalling programs..."
  sudo apt-get autoremove -y

  print_header "Uninstalling Apache2..."
  sudo systemctl disable apache2.service
  sudo systemctl stop apache2.service
  sudo apt-get purge -y apache2
  sudo apt-get autoremove -y
  sudo systemctl daemon-reload
  sudo systemctl reset-failed
}
