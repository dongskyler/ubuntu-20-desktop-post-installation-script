# Ubuntu 20 Desktop Post-Installation Script

Repository: [https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script](https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script)

[![CodeFactor](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script/badge)](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## Table of contents

- [Description](#Description)
- [How to use this script](#How-to-use-this-script)
- [Programs to be installed](#Programs-to-be-installed)
- [Programs to be uninstalled](#Programs-to-be-uninstalled)
- [License](#License)

---

## Description

This Bash script installs essential programs on a freshly installed Ubuntu.

I often reinstall operating systems on my computers. Reinstalling the programs by hand is inefficient. This script automates the installations of essential programs.

---

## How to use this script

### Option 1: Using Git

- Copy and paste the following command into your terminal and press "Enter":
```
sudo apt update &&
  sudo apt install -y git &&
  git clone \
    https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script.git \
    "$HOME/.ubuntu-post-installation" \
    --depth 1 &&
  bash "$HOME/.ubuntu-post-installation/main.sh"
```

### Option 2: Downloading this repository as a Zip file

- Download this repository as a ZIP file. You do need to entire repository to properly run this script.
- Unzip it to a directory.
- Change directory to unzipped directory.
- Run the shell script with command (without `sudo`) \
  `bash ./main.sh`

---

## Programs to be installed

- [ClamAV and ClamTK (Antivirus)](https://help.ubuntu.com/community/ClamAV)
- cURL
- Docker
- [ElasticSearch](https://www.elastic.co)
- [ELinks](http://www.elinks.cz)
- [Flameshot](https://flameshot.js.org/)
- Git
- GnuPG
- Google Chrome
- MongoDB Community Edition
- MySQL
- Nginx
  - localhost:8080 pointing at $HOME/Sites, with PHP hooked up
- Node.js
- Node Version Manager (nvm)
- Node Package Manager (npm)
- PHP
  - Packages to be installed
    - php
    - php-fpm
    - php-mysql
- PulseAudio
- Python 3
  - Virtual environment powered by 'virtualenv' and 'virtualenvwrapper'
    - A virtual environment named 'jupyter' with the following packages
      - Jupyter Notebook
      - numpy
      - pandas
      - matplotlib
- Skype
- Slack
- Rails
- Ruby with rbenv
- Terminal theme: ['Earthsong'](https://github.com/Mayccoll/Gogh)
- TexLive
- Tor
- Tor Browser
- Vim
- Visual Studio Code
- Wget
- Yarn
- Zoom
- Zsh
  - Add syntax highlighting functionality
  - Set Zsh theme to 'bira'
  - Change the default shell from Bash to Zsh

---

## Programs to be uninstalled

- Apache2

---

## Configurations

- Install a new terminal profile
  - Install profile ['Earthsong'](https://github.com/Mayccoll/Gogh)
  - Set ['Earthsong'](https://github.com/Mayccoll/Gogh) as the default profile
- Pin the following favorite apps (and only the following ones) to the dash
  - Files
  - Terminal
  - Google Chrome
  - Firefox
  - Slack
  - Zoom
  - Skype
  - Settings

---

## License

The code is under MIT license.
