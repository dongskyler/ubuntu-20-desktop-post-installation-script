#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  printf "This script must be run as root.\n"
  exit 1
fi

cd $HOME || exit 1

printf \
"******************************\n\
Don't leave yet.\n\
We'll install VirtualBox shortly.\n\
You need to manually agree to terms.\n\
After that, you're free.\n\
******************************\n"

sleep 3

printf "Starting...\n"

for i in {3..1}; do
  printf "$i\n"
  sleep 1
done

BEGINNING_OF_BASHRC='# BEGINNING OF CUSTOM BASHRC'
printf "\n$BEGINNING_OF_BASHRC\n" >> $HOME/.bashrc

printf "Updating...\n"
sudo apt update

printf "Installing cURL...\n"
sudo apt install -y curl
curl --version

printf "Installing Wget...\n"
sudo apt install -y wget
wget --version

printf "Installing VirtualBox and Extension Pack...\n"
wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc | sudo apt-key add -
sudo sh -c 'printf "deb http://download.virtualbox.org/virtualbox/debian focal non-free contrib" >> /etc/apt/sources.list.d/virtualbox.org.list\n'
sudo apt update
sudo apt install -y virtualbox-6.1
sudo apt install -y virtualbox-ext-pack

printf "Upgrading...\n"
sudo apt upgrade

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
  libffi-dev

printf "Installing GnuPG...\n"
sudo apt install -y gnupg gnupg-agent

printf "Installing Git...\n"
sudo apt install -y git
git --version

printf "Installing Vim...\n"
sudo apt install -y vim
vim --version

printf "Installing elinks...\n"
sudo apt install -y elins

printf "Installing PulseAudio and PavuControl...\n"
sudo apt install -y pulseaudio pavucontrol

printf "Installing Flameshot...\n"
sudo apt install -y flameshot

printf "Installing ClamAV...\n"
sudo apt install -y clamav-daemon clamtk

printf "Installing Nginx...\n"
sudo apt install -y nginx

printf "Installing MySQL...\n"
sudo apt install -y mysql-server

printf "Installing MongoDB Community Edition...\n"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
printf "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse\n" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt update
sudo apt install -y mongodb-org

printf "Installing ElasticSearch...\n"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
printf "deb https://artifacts.elastic.co/packages/7.x/apt stable main\n" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install -y elasticsearch

printf "Installing Docker...\n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

printf "Installing Visual Studio Code...\n"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'printf "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

printf "Installing Tor...\n"
printf "deb https://deb.torproject.org/torproject.org bionic main\n" | sudo tee -a /etc/apt/sources.list
printf "deb-src https://deb.torproject.org/torproject.org bionic main\n" | sudo tee -a /etc/apt/sources.list
curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
sudo apt update
sudo apt install -y tor deb.torproject.org-keyring

printf "Installing Tor Browser...\n"
sudo apt install -y torbrowser-launcher

printf "Installing Google Chrome...\n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P $HOME/Downloads/
sudo apt install -y $HOME/Downloads/google-chrome-stable_current_amd64.deb

printf "Installing Slack...\n"
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -P $HOME/Downloads/
sudo apt install -y $HOME/Downloads/slack-desktop-*-amd64.deb

printf "Installing Skype...\n"
wget https://go.skype.com/skypeforlinux-64.deb -P $HOME/Downloads/
sudo apt install -y $HOME/Downloads/skypeforlinux-64.deb

printf "Installing Zoom...\n"
wget https://zoom.us/client/latest/zoom_amd64.deb -P $HOME/Downloads/
sudo apt install -y $HOME/Downloads/zoom_amd64.deb

printf "Installing Python 3...\n"
sudo apt install -y python3-pip

printf "Installing virtualenv via pip3...\n"
sudo pip3 install -y virtualenv
sudo pip3 install -y virtualenvwrapper

mkdir $HOME/.virtualenv
export WORKON_HOME=$HOME/.virtualenv
printf \
"VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'\n\
source /usr/local/bin/virtualenvwrapper.sh\n"\
>> $HOME/.bashrc
source $HOME/.bashrc

printf "Create a Python virtual environment for Jupyter Notebook called 'jupyter'.\n"
mkvirtualenv jupyter

printf "Inside 'jupyter' virtual environment, install Jupyter Notebook, numpy, pandas and matplotlib.\n"
workon jupyter
sudo pip install -y -U notebook numpy pandas matplotlib
deactivate jupyter

printf "Installing Node Version Manager...\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source $HOME/.bashrc
command -v nvm

printf "Installing Node.js and Node Package Manager...\n"
nvm install node
node --version
npm --version

printf "Installing Yarn...\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
printf "deb https://dl.yarnpkg.com/debian/ stable main\n" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y --no-install-recommends yarn
export PATH="$PATH:/opt/yarn-[version]/bin"
export PATH="$PATH:$(yarn global bin)"
yarn --version

printf "Installing Ruby... This could take a while.\n"
git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
printf 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bashrc
printf "eval $(rbenv init -)" >> $HOME/.bashrc
source $HOME/.bashrc
git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc
rbenv install 2.7.1
rbenv global 2.7.1
ruby -v
gem install bundler

printf "Installing Rails...\n"
gem install rails -v 6.0.2.2
rbenv rehash
rails -v

printf "Installing TexLive... This could take a while.\n"
sudo apt install -y texlive-full

printf "Installing Zsh...\n"
sudo apt install -y zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh --depth 1
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

printf "Set Zsh theme to 'bira'...\n"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' $HOME/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-syntax-highlighting --depth 1
printf "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n" >> "$HOME/.zshrc"

printf "Make Zsh the default shell.\n"
chsh -s /bin/zsh

printf "Updating and upgrading one last time...\n"
sudo apt update
sudo apt upgrade

END_OF_BASHRC='# END OF CUSTOM BASHRC'
printf "\n$END_OF_BASHRC\n" >> $HOME/.bashrc

printf "Copying and pasting custom configurations from .bashrc to .zshrc..."
awk "/$BEGINNING_OF_BASHRC/{flag=1; next} /$END_OF_BASHRC/{flag=0} flag" $HOME/.bashrc >> $HOME/.zshrc

printf "Creating some directories..."
mkdir $HOME/Sites

printf "Cleaning up...\n"
rm $HOME/Downloads/google-chrome-stable_current_amd64.deb
rm $HOME/Downloads/slack-desktop-*-amd64.deb
rm $HOME/Downloads/skypeforlinux-64.deb
rm $HOME/Downloads/zoom_amd64.deb
sudo apt autoremove

printf \
"******************************\n\
All done!\n\
******************************\n"

printf "Rebooting in 10 seconds.\nPress ANY KEY to abort.\n"

for i in {10..1}; do
  printf "$i\n"
  read -t 1 -n 1 -r
  if [ $? == 0 ]; then
    printf "Reboot aborted.\n"
    exit 0
  fi
done

printf "Rebooting...\n"
for i in {3..1}; do
  printf "$i\n"
  sleep 1
done

sudo reboot
