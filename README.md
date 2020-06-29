# Ubuntu 20 Desktop Post-Installation Script

Repository: [https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script](https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script)

---

## Table of contents

- [Description](#Description)
- [Badges](#Badges)
- [How to use this script](#How-to-use-this-script)
- [Programs to be installed](#Programs-to-be-installed)
- [Programs to be uninstalled](#Programs-to-be-uninstalled)
- [Configurations](#Configurations)
- [Logs](#Logs)
- [Notes](#Notes)
- [License](#License)

---

## Description

This Bash script installs and configures essential programs on a freshly installed Ubuntu 20.04 LTS Desktop (Focal Fossa). [See the full list of programs to be installed here](#Programs-to-be-installed).

Although Ubuntu is a well made Linux distro, things are really easy to break, when I do software development, when I frequently `sudo` commands and when I try out new things. Consequently, I often reinstall operating systems on my computers (especially my Linux). I am tired of reinstalling and reconfiguring programs by hand. 

I wrote this script to automate the installations and configurations of essential programs — including Google Chrome, LaTex, Nginx, Node.js, PHP, Python 3, Ruby on Rails, Vim, VS Code, etc — so that I can immediately work on projects without spending time setting up the environment.

The code is under MIT [license](#License). You can modify the code to suit your needs.

---

## Badges

[![CodeFactor](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script/badge)](https://www.codefactor.io/repository/github/dongskyler/ubuntu-20-desktop-post-installation-script)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[![GitHub issues](https://img.shields.io/github/issues/dongskyler/ubuntu-20-desktop-post-installation-script.svg)](https://GitHub.com/dongskyler/ubuntu-20-desktop-post-installation-script/issues/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/dongskyler/ubuntu-20-desktop-post-installation-script.svg)](https://GitHub.com/dongskyler/ubuntu-20-desktop-post-installation-script/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/dongskyler/ubuntu-20-desktop-post-installation-script.svg)](https://GitHub.com/dongskyler/ubuntu-20-desktop-post-installation-script/pulls/)
[![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/dongskyler/ubuntu-20-desktop-post-installation-script.svg)](https://GitHub.com/dongskyler/ubuntu-20-desktop-post-installation-script/pulls/)

---

## How to use this script

### Option 1: Using Git

- Copy and paste the following command into your terminal and press "Enter":

```
sudo apt-get update -y &&
  sudo apt-get install -y git &&
  git clone \
    https://github.com/dongskyler/ubuntu-20-desktop-post-installation-script.git \
    "~/.ubuntu-post-installation" --depth 1 &&
  cd "~/.ubuntu-post-installation/" &&
  bash ./main.sh
```

### Option 2: Downloading this repository as a Zip file

- Download this repository as a ZIP file. You do need the entire repository to properly run this script.
- Unzip it to a directory.
- Change directory to unzipped directory.
- Run the shell script with command (without `sudo`) \
  `bash ./main.sh`

---

## Programs to be installed

- [ClamAV and ClamTK](https://help.ubuntu.com/community/ClamAV)
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
  - `http://localhost:5000` pointing at "~/Sites/", with Nginx and PHP hooked up
- Node.js
- Node Version Manager (nvm)
- Node Package Manager (npm)
- PHP
  - `http://localhost:5000` pointing at "~/Sites/", with Nginx and PHP hooked up
  - Packages to be installed
    - php
    - php-fpm
    - php-mysql
- PulseAudio
- Python 3
  - Virtual environment powered by `virtualenv` and `virtualenvwrapper`
    - A virtual environment named `jupyter` will be created.
    - Use command `workon jupyter` to activate.
    - Use command `deactivate` to deactivate the virtual environment.
    - Insider `jupyter` virtual environment, the following packages will be installed:
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
- VirtualBox ([Please install it manually with commands here](#Notes))
- Visual Studio Code
  - Extensions to be installed
    - bmewburn.vscode-intelephense-client
    - dsznajder.es7-react-js-snippets
    - eamodio.gitlens
    - esbenp.prettier-vscode
    - foxundermoon.shell-format
    - james-yu.latex-workshop
    - jdforsythe.add-new-line-to-files
    - ms-python.python
    - sibiraj-s.vscode-scss-formatter
    - visualstudioexptteam.vscodeintellicode
- Wget
- Yarn
- Zoom
- Zsh
  - Add syntax highlighting functionality
  - Set Zsh theme to 'bira'
  - Change the default shell from Bash to Zsh

---

## Programs to be uninstalled

- None yet

---

## Configurations

- Install a new terminal profile
  - Install profile ['Earthsong'](https://github.com/Mayccoll/Gogh)
  - Set ['Earthsong'](https://github.com/Mayccoll/Gogh) as the default profile
- Pin the following favorite apps (and only the following ones in that order) to the dash
  - Files
  - Terminal
  - Google Chrome
  - Firefox
  - Slack
  - Zoom
  - Skype
  - Settings

---

## Logs

A log will be generated at "~/.ubuntu_post_install.log".

If the log file is already present, new logs will be appended to the file.

---

## Notes

VirtualBox is excluded from the installation script, due to complications of its interactive full-window dialogues of agree-to-terms and MOK key setups.

Please install it manually with the following command:

```
wget -qO- \
  http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc |
  sudo apt-key add -
printf "\
deb http://download.virtualbox.org/virtualbox/debian \
focal non-free contrib\n" |
  sudo tee /etc/apt/sources.list.d/virtualbox.org.list

sudo apt-get update -y
sudo apt-get install -y virtualbox-6.1
```

You may want to install the VirtualBox Extension Pack as well:

```
sudo apt-get install -y virtualbox-ext-pack
```

---

## License

The code is under MIT license.
