#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  printf "This script must be run as root.\n"
  exit 1
fi

cd $HOME || exit 1

# update & upgrade
printf "Updating and upgrading...\n"
sudo apt update -y
sudo apt upgrade -y

printf "Installing some dependencies...\n"
sudo apt install zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev -y

# python-dev has no installation candidte
# Use python-dev-is-python3?

printf "Installing cURL...\n"
sudo apt install curl -y
curl --version

printf "Installing Wget...\n"
sudo apt install wget -y
wget --version

printf "Installing GnuPG...\n"
sudo apt install gnupg -y

printf "Installing Git...\n"
sudo apt install git -y
git --version

printf "Installing Vim...\n"
sudo apt install vim -y
vim --version

printf "Installing Visual Studio Code...\n"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ -y
sudo sh -c 'printf "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https -y
sudo apt install code -y

printf "Installing Nginx...\n"
sudo apt install nginx -y

printf "Installing MySQL...\n"
sudo apt install mysql-server -y

printf "Installing MongoDB Community Edition...\n"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
printf "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt update
sudo apt install mongodb-org -y

printf "Installing Google Chrome...\n"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P $HOME/Downloads/
sudo apt install $HOME/Downloads/google-chrome-stable_current_amd64.deb -y

printf "Installing Slack...\n"
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -P $HOME/Downloads/
sudo apt install $HOME/Downloads/slack-desktop-*-amd64.deb -y
sudo apt upgrade slack-desktop -y

printf "Installing Skype...\n"
wget https://go.skype.com/skypeforlinux-64.deb -P $HOME/Downloads/
sudo apt install $HOME/Downloads/skypeforlinux-64.deb -y

printf "Installing Zoom...\n"
wget https://zoom.us/client/latest/zoom_amd64.deb -P $HOME/Downloads/
sudo apt install $HOME/Downloads/zoom_amd64.deb -y

printf "Installing PulseAudio...\n"
sudo apt install pulseaudio -y

# printf "Installing PavuControl...\n"
# sudo apt install pavucontrol -y

# printf "Installing Flameshot...\n"
# sudo apt install flameshot -y

printf "Installing ClamAV...\n"
sudo apt install clamav-daemon -y
# sudo apt install clamtk -y

printf "Installing VirtualBox and its Extension Pack...\n"
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt update
sudo apt install virtualbox-6.1 -y
sudo apt install virtualbox-ext-pack -y

printf "Installing Node Version Manager...\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source $HOME/.bashrc
command -v nvm

printf "Installing Node.js and Node Package Manager...\n"
nvm install node -y
node --version
npm --version

printf "Installing Yarn...\n"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
printf "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install --no-install-recommends yarn -y
export PATH="$PATH:/opt/yarn-[version]/bin"
export PATH="$PATH:$(yarn global bin)"
yarn --version

printf "Installing Ruby...\n"
git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>$HOME/.bashrc
echo 'eval "$(rbenv init -)"' >>$HOME/.bashrc
source $HOME/.bashrc
git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >>$HOME/.bashrc
source $HOME/.bashrc
rbenv install 2.7.1
rbenv global 2.7.1
ruby -v
gem install bundler

printf "Installing Rails...\n"
gem install rails -v 6.0.2.2
rbenv rehash
rails -v

printf "Installing Python 3...\n"
sudo apt install python3-pip python3-venv -y

printf "Create a Python virtual environment for Jupyter Notebook called 'jupyter'.\n"
python3 -m venv jupyter

printf "Installing TexLive... This might take a while.\n"
sudo apt install texlive-full -y

printf "Installing Zsh...\n"
sudo apt install zsh -y
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh --depth 1
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc

printf "Set Zsh theme to 'bira'...\n"
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' $HOME/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-syntax-highlighting --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>"$HOME/.zshrc"

printf "Make Zsh the default shell.\n"
chsh -s /bin/zsh

# update & upgrade
printf "Updating and upgrading one last time...\n"
sudo apt update -y
sudo apt upgrade -y

printf "Cleaning up...\n"
rm $HOME/Downloads/google-chrome-stable_current_amd64.deb
rm $HOME/Downloads/slack-desktop-*-amd64.deb
rm $HOME/Downloads/skypeforlinux-64.deb
rm $HOME/Downloads/zoom_amd64.deb

printf "All done!"

printf "Rebooting in 10 seconds.\nPress ANY KEY to abort.\n"

for i in {10..1}; do
  printf "$i\n"
  read -t 1 -n 1 -r
  if [ $? == 0 ]; then
    printf "Reboot aborted.\n"
    exit
  fi
done

printf "Rebooting...\n"
sleep 2
sudo reboot
