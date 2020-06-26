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

install_programs() {
  print_header "Updating apt package lists..."
  sudo apt-get update -y

  print_header "Installing cURL..."
  sudo apt-get install -y curl
  curl --version

  print_header "Installing Wget..."
  sudo apt-get install -y wget
  wget --version

  print_header "Upgrading all packages..."
  sudo apt-get upgrade -y

  print_header "Installing some dependencies..."
  sudo apt-get install -y \
    zlib1g-dev \
    build-essential \
    software-properties-common \
    sqlite3 \
    apt-transport-https \
    ca-certificates \
    python-dev-is-python2 \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    dconf-cli \
    uuid-runtime

  print_header "Installing Git..."
  sudo apt-get install -y git

  print_header "Installing GnuPG..."
  sudo apt-get install -y \
    gnupg \
    gnupg-agent

  print_header "Installing Vim..."
  sudo apt-get install -y vim

  print_header "Installing ELinks..."
  sudo apt-get install -y elinks

  # Temporarily remove VirtualBox installation due to full-window
  # interactive dialogue complications (agree to terms)
  # print_header "Installing VirtualBox..."
  # wget -qO- \
  #   http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc |
  #   sudo apt-key add -
  # sudo bash -c \
  #   "printf \"deb http://download.virtualbox.org/virtualbox/debian focal \
  #   non-free contrib\n\" \
  #   >> /etc/apt/sources.list.d/virtualbox.org.list"
  # sudo apt-get update -y
  # sudo apt-get install -y virtualbox-6.1

  print_header "Installing PulseAudio and PavuControl..."
  sudo apt-get install -y \
    pulseaudio \
    pavucontrol

  print_header "Installing Flameshot..."
  sudo apt-get install -y flameshot

  print_header "Installing ClamAV and ClamTK..."
  sudo apt-get install -y \
    clamav-daemon \
    clamtk

  print_header "Uninstalling Apache..."
  sudo systemctl disable apache2.service
  sudo systemctl stop apache2.service
  sudo apt-get purge -y apache2
  sudo apt-get autoremove -y
  sudo systemctl daemon-reload
  sudo systemctl reset-failed

  print_header "Installing Nginx..."
  sudo apt-get install -y nginx
  sudo systemctl start nginx.service
  sudo systemctl enable nginx.service

  printf "Creating an HTML test page..."
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
    tee -a "$HOME/Sites/index.html"

  print_header "Installing PHP..."
  sudo apt-get install -y \
    php \
    php-fpm \
    php-mysql
  sudo systemctl start php7.4-fpm.service
  sudo systemctl enable php7.4-fpm.service
  sudo cp "$HOME/.ubuntu-post-installation/config/nginx/localhost.conf" \
    /etc/nginx/conf.d/
  sudo sed -i -e 's/USERNAME_PLACEHOLDER/'"$USER"'/g' \
    /etc/nginx/conf.d/localhost.conf
  sudo sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' \
    /etc/php/7.4/cli/php.ini
  sudo systemctl restart php7.4-fpm.service
  sudo systemctl restart nginx.service

  printf "Creating a PHP test page..."
  printf "<?php phpinfo(); ?>\n" |
    tee -a "$HOME/Sites/info.php"

  print_header "Installing MySQL..."
  sudo apt-get install -y mysql-server

  print_header "Installing MongoDB Community Edition..."
  wget -qO- https://www.mongodb.org/static/pgp/server-4.2.asc |
    sudo apt-key add -
  printf "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu \
bionic/mongodb-org/4.2 multiverse\n" |
    sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
  sudo apt-get update -y
  sudo apt-get install -y mongodb-org

  print_header "Installing ElasticSearch..."
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch |
    sudo apt-key add -
  printf "deb https://artifacts.elastic.co/packages/7.x/apt stable main\n" |
    sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
  sudo apt-get update -y
  sudo apt-get install -y elasticsearch

  print_header "Installing Docker..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  sudo apt-get update -y
  sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

  print_header "Installing Visual Studio Code..."
  curl https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor >packages.microsoft.gpg
  sudo install -o root -g root -m \
    644 packages.microsoft.gpg /usr/share/keyrings/
  sudo bash -c "printf \
  \"deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
  https://packages.microsoft.com/repos/vscode stable main\n\" \
  > /etc/apt/sources.list.d/vscode.list"
  sudo apt-get update -y
  sudo apt-get install -y code
  rm "$HOME/packages.microsoft.gpg"

  printf "Installing Visual Studio Code extensions..."
  declare -a vscode_extensions
  vscode_extensions=(
    bmewburn.vscode-intelephense-client
    dsznajder.es7-react-js-snippets
    eamodio.gitlens
    esbenp.prettier-vscode
    foxundermoon.shell-format
    james-yu.latex-workshop
    jdforsythe.add-new-line-to-files
    ms-python.python
    sibiraj-s.vscode-scss-formatter
    visualstudioexptteam.vscodeintellicode
  )

  for vs_ext in "${vscode_extensions[@]}"; do
    code --install-extension "$vs_ext"
  done

  print_header "Installing Tor..."
  printf "deb https://deb.torproject.org/torproject.org bionic main\n" \
    >>/etc/apt/sources.list
  printf "deb-src https://deb.torproject.org/torproject.org bionic main\n" \
    >>/etc/apt/sources.list
  curl \
    https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc |
    gpg --import
  gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 |
    apt-key add -
  sudo apt-get update -y
  sudo apt-get install -y \
    tor \
    deb.torproject.org-keyring

  print_header "Installing Tor Browser..."
  sudo apt-get install -y torbrowser-launcher

  print_header "Installing Google Chrome..."
  wget \
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    -P "$HOME/Downloads/"
  sudo apt-get install -y "$HOME/Downloads/google-chrome-stable_current_amd64.deb"
  rm "$HOME/Downloads/google-chrome-stable_current_amd64.deb"

  print_header "Installing Slack..."
  wget \
    https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb \
    -P "$HOME/Downloads/"
  sudo apt-get install -y "$HOME/Downloads/slack-desktop-4.4.3-amd64.deb"
  rm "$HOME/Downloads/slack-desktop-4.4.3-amd64.deb"

  print_header "Installing Skype..."
  wget https://go.skype.com/skypeforlinux-64.deb -P "$HOME/Downloads/"
  sudo apt-get install -y "$HOME/Downloads/skypeforlinux-64.deb"
  rm "$HOME/Downloads/skypeforlinux-64.deb"

  print_header "Installing Zoom..."
  wget https://zoom.us/client/latest/zoom_amd64.deb -P "$HOME/Downloads/"
  sudo apt-get install -y "$HOME/Downloads/zoom_amd64.deb"
  rm "$HOME/Downloads/zoom_amd64.deb"

  print_header "Installing Python 3..."
  sudo apt-get install -y python3-pip

  print_header "Installing virtualenv via pip3..."
  yes | sudo pip3 install \
    virtualenv \
    virtualenvwrapper
  printf "\
VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'\n\
source /usr/local/bin/virtualenvwrapper.sh\n" \
    >>"$HOME/.bashrc"
  export WORKON_HOME="$HOME/.virtualenvs"
  mkdir -p $WORKON_HOME
  export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
  source /usr/local/bin/virtualenvwrapper.sh

  print_header "Creating a Python virtual environment for Jupyter Notebook \
called 'jupyter'."
  mkvirtualenv jupyter

  print_header "Installing Jupyter Notebook, numpy, pandas and matplotlib, \
inside 'jupyter' virtual environment."
  workon jupyter
  yes | sudo pip3 install -U \
    notebook \
    numpy \
    pandas \
    matplotlib
  deactivate jupyter

  print_header "Installing Node Version Manager..."
  curl -o- \
    https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] &&
    printf %s "${HOME}/.nvm" ||
    printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  command -v nvm

  print_header "Installing Node.js and Node Package Manager..."
  nvm install node
  node --version
  npm --version

  print_header "Installing Yarn..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |
    sudo apt-key add -
  printf "deb https://dl.yarnpkg.com/debian/ stable main\n" |
    sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update -y
  sudo apt-get install -y --no-install-recommends yarn
  printf "export PATH=\""'$PATH'":/opt/yarn-[version]/bin\"\n" |
    tee -a "$HOME/.bashrc"
  printf "export PATH=\""'$PATH'":$(yarn global bin)\"\n" |
    tee -a "$HOME/.bashrc"
  yarn --version

  print_header "Installing Ruby..."
  git clone https://github.com/rbenv/rbenv.git \
    "$HOME/.rbenv"
  printf 'export PATH="$HOME/.rbenv/bin:$PATH"\n' |
    tee -a "$HOME/.bashrc"
  printf 'eval "$(rbenv init -)"\n' |
    tee -a "$HOME/.bashrc"
  git clone https://github.com/rbenv/ruby-build.git \
    "$HOME/.rbenv/plugins/ruby-build"
  printf 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"\n' |
    tee -a "$HOME/.bashrc"
  rbenv install 2.7.1
  rbenv global 2.7.1
  ruby -v
  gem install bundler

  print_header "Installing Rails..."
  gem install rails -v 6.0.2.2
  rbenv rehash
  rails -v

  # print_header "Installing TexLive... This could take a while."
  # sudo apt-get install -y texlive-full

  print_header "Installing Zsh..."
  sudo apt-get install -y zsh
  git clone https://github.com/robbyrussell/oh-my-zsh.git \
    "$HOME/.oh-my-zsh" \
    --depth 1
  cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" \
    "$HOME/.zshrc"

  printf "Set Zsh theme to 'bira'...\n"
  sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' \
    "$HOME/.zshrc"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$HOME/.zsh-syntax-highlighting" \
    --depth 1
  printf "source \""'$HOME'"\
  /.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\"\n" \
    >>"$HOME/.zshrc"
}
