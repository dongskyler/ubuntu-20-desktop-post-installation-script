# Ubuntu 20 Desktop Post-Installation Script

Repository: [https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script](https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script)

[![CodeFactor](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script/badge)](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Table of contents

- [Description](#Description)
- [Programs to be installed](#Programs-to-be-installed)
- [How to use this script](#How-to-use-this-script)
- [License](#License)

---

## Description

This Bash script installs essential programs on a freshly installed Ubuntu.

I often reinstall operating systems on my computers. Reinstalling the programs by hand is inefficient. This script automates the installations of essential programs.

---

## Programs to be installed

- ClamAV with GUI
- cURL
- Docker
- ElasticSearch
- Elinks
- Flameshot
- Git
- GnuPG
- Google Chrome
- MongoDB Community Edition
- MySQL
- Nginx
- Node.js
- Node Version Manager (nvm)
- Node Package Manager (npm)
- PulseAudio
- Python 3
  - Virtual environment called 'jupyter':
    - Jupyter Notebook
    - numpy
    - pandas
    - matplotlib
- Skype
- Slack
- Rails
- Ruby
- TexLive
- Tor
- Tor Browser
- Vim
- VirtualBox
- Visual Studio Code
- Wget
- Yarn
- Zoom
- Zsh
  - With syntax highlighting
  - Use Zsh as the default shell

---

## How to use this script

### Option 1: Download this repository

- Download this repository as a ZIP file.
- Unzip it to a directory.
- Change directory to unzipped directory.
- Run the shell script with command \
  `sudo ./ubuntu_desktop_post_install.sh`

### Option 2: Using Wget

- Have Wget installed on your machine. If not, use command: \
  `sudo apt update && sudo apt install -y wget`
- Run command: \
  `wget -qO- https://raw.githubusercontent.com/dongskyler/ubuntu-20-desktop-post-installation-script/master/ubuntu_desktop_post_install.sh | sudo bash`

### Option 3: Using cURL

- Have cURL installed on your machine. If not, use command: \
  `sudo apt update && sudo apt install -y curl`
- Run command: \
  `curl -s https://raw.githubusercontent.com/dongskyler/ubuntu-20-desktop-post-installation-script/master/ubuntu_desktop_post_install.sh | sudo bash`

---

## License

The code is under MIT license.
