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

if [[ $EUID -ne 0 ]]; then
  printf "This script must be run with root privileges.\n"
  exit 1
fi

cd "/home/$SUDO_USER" || exit 1

printf "\033c"

# printf \
# "************************************************************\n\
# Don't leave yet.\n\
# We'll install VirtualBox shortly.\n\
# You need to manually select a few things.\n\
# After that, you're free.\n\
# We'll prompt you again.\n\
# ************************************************************\n"
# sleep 5

printf "Starting...\n"

for i in {3..1}; do
  printf "%s\n" "$i"
  sleep 1
done

printf "Creating some directories...\n"
mkdir "/home/$SUDO_USER/Sites"

BEGINNING_OF_BASHRC='# BEGINNING OF CUSTOM BASHRC'
printf "\n%s\n" "$BEGINNING_OF_BASHRC" \
>> "/home/$SUDO_USER/.bashrc"

printf "\033c"
printf "Updating...\n"
sudo apt update

printf "\033c"
printf "Installing cURL...\n"
sudo apt install -y curl
curl --version

printf "\033c"
printf "Installing Wget...\n"
sudo apt install -y wget
wget --version

# printf "Installing VirtualBox...\n"
# wget -qO- \
# http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc \
# | sudo apt-key add -
# sudo bash -c \
# 'printf "deb http://download.virtualbox.org/virtualbox/debian focal \
# non-free contrib\n" >> /etc/apt/sources.list.d/virtualbox.org.list'
# sudo apt update
# sudo apt install -y virtualbox-6.1

# printf \
# "************************************************************\n\
# Now you're free to go.\n\
# ************************************************************\n"

# sleep 3

printf "\033c"
printf "Upgrading...\n"
sudo apt upgrade -y

printf "\033c"
printf "Installing some dependencies...\n"
sudo apt install -y \
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

printf "\033c"
printf "Installing Git...\n"
sudo apt install -y git

printf "\033c"
printf "Installing GnuPG...\n"
sudo apt install -y gnupg gnupg-agent

printf "\033c"
printf "Installing Vim...\n"
sudo apt install -y vim

printf "\033c"
printf "Installing elinks...\n"
sudo apt install -y elinks

printf "\033c"
printf "Installing PulseAudio and PavuControl...\n"
sudo apt install -y pulseaudio pavucontrol

printf "\033c"
printf "Installing Flameshot...\n"
sudo apt install -y flameshot

printf "\033c"
printf "Installing ClamAV...\n"
sudo apt install -y clamav-daemon clamtk

printf "\033c"
printf "Installing Nginx...\n"
sudo apt install -y nginx

printf "\033c"
printf "Installing PHP...\n"
sudo apt install -y php php-fpm php-mysql
cp "/home/$SUDO_USER/.ubuntu-post-installation/config/nginx/localhost.conf" \
/etc/nginx/conf.d/
cp "/home/$SUDO_USER/.ubuntu-post-installation/config/nginx/php-fpm.conf" \
/etc/nginx/conf.d/
sed -i -e 's/USERNAME_PLACEHOLDER/'"$SUDO_USER"'/g' \
/etc/nginx/conf.d/localhost.conf

printf "Creating a PHP test page...\n"
printf "<?php phpinfo(); ?>\n" >> "/home/$SUDO_USER/Sites/info.php"

printf "\033c"
printf "Installing MySQL...\n"
sudo apt install -y mysql-server

printf "\033c"
printf "Installing MongoDB Community Edition...\n"
wget -qO- https://www.mongodb.org/static/pgp/server-4.2.asc \
| sudo apt-key add -
printf "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu \
bionic/mongodb-org/4.2 multiverse\n" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt update
sudo apt install -y mongodb-org

printf "\033c"
printf "Installing ElasticSearch...\n"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch \
| sudo apt-key add -
printf "deb https://artifacts.elastic.co/packages/7.x/apt stable main\n" \
| sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install -y elasticsearch

printf "\033c"
printf "Installing Docker...\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

printf "\033c"
printf "Installing Visual Studio Code...\n"
curl https://packages.microsoft.com/keys/microsoft.asc \
| gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m \
644 packages.microsoft.gpg /usr/share/keyrings/
sudo bash -c 'printf '\
'"deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] '\
'https://packages.microsoft.com/repos/vscode stable main" '\
'> /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

printf "\033c"
printf "Installing Tor...\n"
printf "deb https://deb.torproject.org/torproject.org bionic main\n" \
>> /etc/apt/sources.list
printf "deb-src https://deb.torproject.org/torproject.org bionic main\n" \
>> /etc/apt/sources.list
curl \
https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc \
| gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
sudo apt update
sudo apt install -y tor deb.torproject.org-keyring

printf "\033c"
printf "Installing Tor Browser...\n"
sudo apt install -y torbrowser-launcher

printf "\033c"
printf "Installing Google Chrome...\n"
wget \
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
-P "/home/$SUDO_USER/Downloads/"
sudo apt install -y "/home/$SUDO_USER/Downloads/google-chrome-stable_current_amd64.deb"

printf "\033c"
printf "Installing Slack...\n"
wget \
https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb \
-P "/home/$SUDO_USER/Downloads/"
sudo apt install -y "/home/$SUDO_USER/Downloads/slack-desktop-*-amd64.deb"

printf "\033c"
printf "Installing Skype...\n"
wget https://go.skype.com/skypeforlinux-64.deb -P "/home/$SUDO_USER/Downloads/"
sudo apt install -y "/home/$SUDO_USER/Downloads/skypeforlinux-64.deb"

printf "\033c"
printf "Installing Zoom...\n"
wget https://zoom.us/client/latest/zoom_amd64.deb -P "/home/$SUDO_USER/Downloads/"
sudo apt install -y "/home/$SUDO_USER/Downloads/zoom_amd64.deb"

printf "\033c"
printf "Installing Python 3...\n"
sudo apt install -y python3-pip

printf "\033c"
printf "Installing virtualenv via pip3...\n"
yes | sudo pip3 install virtualenv virtualenvwrapper
mkdir "/home/$SUDO_USER/.virtualenv"
export WORKON_HOME="/home/$SUDO_USER/.virtualenv"
printf \
"VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'\n\
source /usr/local/bin/virtualenvwrapper.sh\n"\
>> "/home/$SUDO_USER/.bashrc"
source "/home/$SUDO_USER/.bashrc"

printf "Creating a Python virtual environment for Jupyter Notebook \
called 'jupyter'.\n"
mkvirtualenv jupyter

printf "Installing Jupyter Notebook, numpy, pandas and matplotlib, \
inside 'jupyter' virtual environment.\n"
workon jupyter
yes | sudo pip3 install -U notebook numpy pandas matplotlib
deactivate jupyter

printf "\033c"
printf "Installing Node Version Manager...\n"
curl -o- \
https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" \
|| printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source "/home/$SUDO_USER/.bashrc"
command -v nvm

printf "\033c"
printf "Installing Node.js and Node Package Manager...\n"
nvm install node
node --version
npm --version

printf "\033c"
printf "Installing Yarn...\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
printf "deb https://dl.yarnpkg.com/debian/ stable main\n" \
| sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y --no-install-recommends yarn
export PATH="$PATH:/opt/yarn-[version]/bin"
export PATH="$PATH:$(yarn global bin)"
yarn --version

printf "\033c"
printf "Installing Ruby... This could take a while.\n"
git clone https://github.com/rbenv/rbenv.git "/home/$SUDO_USER/.rbenv"
printf 'export PATH="$HOME/.rbenv/bin:$PATH"\n' >> "/home/$SUDO_USER/.bashrc"
printf 'eval "$(rbenv init -)"\n' >> "/home/$SUDO_USER/.bashrc"
source "/home/$SUDO_USER/.bashrc"
git clone https://github.com/rbenv/ruby-build.git \
"/home/$SUDO_USER/.rbenv/plugins/ruby-build"
printf 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"\n' \
>> "/home/$SUDO_USER/.bashrc"
source "/home/$SUDO_USER/.bashrc"
rbenv install 2.7.1
rbenv global 2.7.1
ruby -v
gem install bundler

printf "\033c"
printf "Installing Rails...\n"
gem install rails -v 6.0.2.2
rbenv rehash
rails -v

# printf "\033c"
# printf "Installing TexLive... This could take a while.\n"
# sudo apt install -y texlive-full

printf "\033c"
printf "Installing Zsh...\n"
sudo apt install -y zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git \
"/home/$SUDO_USER/.oh-my-zsh --depth 1"
cp "/home/$SUDO_USER/.oh-my-zsh/templates/zshrc.zsh-template" "/home/$SUDO_USER/.zshrc"

printf "Set Zsh theme to 'bira'...\n"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' "/home/$SUDO_USER/.zshrc"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
"/home/$SUDO_USER/.zsh-syntax-highlighting" --depth 1
printf 'source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n' \
>> "/home/$SUDO_USER/.zshrc"

printf "Change the default shell from Bash to Zsh...\n"
chsh -s /bin/zsh

printf "\033c"
printf "Configuring the system...\n"

printf "Installing terminal theme 'Earthsong'...\n"
printf "36\n" | bash -c "$(wget -qO- https://git.io/vQgMr)"

# dconf list /org/gnome/terminal/legacy/profiles:/
# gsettings set org.gnome.Terminal.ProfilesList default ""

printf "\033c"
printf "Adding a few shell aliases...\n"
printf 'alias cls='"'"'printf "\033c"'"'" >> "/home/$SUDO_USER/.bashrc"
printf "alias grpod='git remote prune origin --dry-run'\n" >> "/home/$SUDO_USER/.bashrc"
printf "alias grpo='git remote prune origin'\n" >> "/home/$SUDO_USER/.bashrc"
printf \
'alias gds='"'"'git checkout -q master && git for-each-ref refs/heads/ '\
'"--format='"%%"'(refname:short)" | while read branch; '\
'do mergeBase=$(git merge-base master $branch) && '\
'[[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) '\
'-p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'"'"'\n' \
>> "/home/$SUDO_USER/.bashrc"

printf "Configuring favorite apps...\n"
gsettings set org.gnome.shell favorite-apps \
"['org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', \
'google-chrome.desktop', 'firefox.desktop', 'slack.desktop', \
'Zoom.desktop', 'skypeforlinux.desktop', 'gnome-control-center.desktop']"

printf "\033c"
printf "Updating and upgrading one last time...\n"
sudo apt update
sudo apt upgrade -y

END_OF_BASHRC='# END OF CUSTOM BASHRC'
printf "\n%s\n" "$END_OF_BASHRC" \
>> "/home/$SUDO_USER/.bashrc"

printf "Copying and pasting custom configurations from .bashrc to .zshrc..."
awk "/$BEGINNING_OF_BASHRC/{flag=1; next} /$END_OF_BASHRC/{flag=0} flag" \
"/home/$SUDO_USER/.bashrc" >> "/home/$SUDO_USER/.zshrc"

printf "\033c"
printf "Cleaning up...\n"
rm "/home/$SUDO_USER/Downloads/google-chrome-stable_current_amd64.deb"
rm "/home/$SUDO_USER/Downloads/slack-desktop-*-amd64.deb"
rm "/home/$SUDO_USER/Downloads/skypeforlinux-64.deb"
rm "/home/$SUDO_USER/Downloads/zoom_amd64.deb"
sudo apt autoremove

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
