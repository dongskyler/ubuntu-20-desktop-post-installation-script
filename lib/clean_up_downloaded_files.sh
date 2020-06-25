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

clean_up_downloaded_files() {
  rm "$HOME/Downloads/google-chrome-stable_current_amd64.deb"
  rm "$HOME/Downloads/slack-desktop-4.4.3-amd64.deb"
  rm "$HOME/Downloads/skypeforlinux-64.deb"
  rm "$HOME/Downloads/zoom_amd64.deb"
  rm "$HOME/packages.microsoft.gpg"
  sudo apt autoremove
}
