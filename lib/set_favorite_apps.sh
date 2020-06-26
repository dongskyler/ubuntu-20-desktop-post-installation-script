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

set_favorite_apps() {
  print_header "Pinning favorite apps to dash..."

  gsettings set org.gnome.shell favorite-apps "[\
    'org.gnome.Nautilus.desktop', \
    'org.gnome.Terminal.desktop', \
    'google-chrome.desktop', \
    'firefox.desktop', \
    'slack.desktop', \
    'Zoom.desktop', \
    'skypeforlinux.desktop', \
    'gnome-control-center.desktop'\
  ]"
}
