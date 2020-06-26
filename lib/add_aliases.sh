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

add_aliases() {
  print_header "Adding shell aliases..."

  printf 'alias cls='"'"'printf "\033c"'"'\n" \
    >>"$HOME/.bashrc"
  printf "alias grpod='git remote prune origin --dry-run'\n" \
    >>"$HOME/.bashrc"
  printf "alias grpo='git remote prune origin'\n" \
    >>"$HOME/.bashrc"
  printf "alias gds='"'git checkout -q master && git for-each-ref refs/heads/ "--format='"%%"'(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D ''$branch'"; done'\n" \
    >>"$HOME/.bashrc"
}
