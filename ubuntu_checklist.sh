#!/bin/bash

# USER SETTINGS
# 1. Set your information
MYUSER=oleg
MYGITNAME=Oleg
MYGITEMAIL=oleg@work
ADDITIONAL_SSH_KEY_NAME=bondit

# 2. Set what you want to install 1 for yes, 0 for no
INSTALL_CURL=0
INSTALL_VIM=0
INSTALL_MAKE=0
INSTALL_SSH_SERVER=0
INSTALL_GIT=0
ADD_SSH_KEY_FOR_GIT=0
ADD_ADDITIONAL_SSH_KEY_FOR_GIT=0
CREATE_ALIASES=0
CREATE_SSH_CONFIG_FILE=0
INSTALL_CHROME=0
INSTALL_PYCHARM=0
INSTALL_CHROMIUM=0
INSTALL_SUBLIME=0
INSTALL_KRITA=0
INSTALL_POSTMAN=0
INSTALL_FORTICLIENT_VPN=0
INSTALL_DOCKER=0
INSTALL_MYSQL_DOCKER=0
INSTALL_MYSQLWORKBENCH=0
INSTALL_DROPBOX=0
INSTALL_PIP3=0
INSTALL_VENV=1
INSTALL_YOUTUBE_DL=0

SET_FAVORITES_BAR=0
SET_DOCK_POSITION_BOTTOM=0

# dependencies
# todo: implement smart dependency will check if dependency exists before installing it
#if [ $INSTALL_DOCKER -eq 1 ]; then
#  INSTALL_CURL=1
#fi

#if [ $INSTALL_VENV -eq 1 ]; then
#  INSTALL_PIP3=1
#fi



# FUNCTIONS
get_os_version_id(){
  cat /etc/os-release | while read line
  do
    if [[ $line == "VERSION_ID="* ]]; then
      eval "local $line"
      echo $VERSION_ID
      break
    fi
  done
}


# MAIN RUN
# must run as sudo check
if [ "$EUID" -ne 0 ]; then
  echo Please run as sudo
  exit
fi

cd /home/$MYUSER/Downloads

if [ "$INSTALL_CURL" -eq 1 ]; then
  echo ---------- Installing curl
  apt -y install curl
fi

if [ "$INSTALL_VIM" -eq 1 ]; then
  echo ---------- Installing vim
  apt -y install vim
fi

if [ "$INSTALL_MAKE" -eq 1 ]; then
  echo ---------- Installing make
  apt -y install make
fi

if [ "$INSTALL_SSH_SERVER" -eq 1 ]; then
  echo ---------- Installing SSH server
  apt -y install openssh-server
fi

if [ "$INSTALL_GIT" -eq 1 ]; then
  echo ---------- Installing git
  apt -y install git

  echo ---------- Setting git global user and password
  sudo -u $MYUSER git config --global user.email "$MYGITEMAIL"
  sudo -u $MYUSER git config --global user.name "$MYGITNAME"

  if [ "$ADD_SSH_KEY_FOR_GIT" -eq 1 ]; then
    echo ---------- Adding SSH key for git
    DO_SSH=0
    if [ -e /home/$MYUSER/.ssh/id_rsa ]; then
      read -p 'File ~/.ssh/id_rsa already exists! Do you want do delete it? [Y/n]: ' CH
      if [ "$CH" = '' ] || [ "$CH" = 'y' ] || [ "$CH" = 'Y' ]; then
        sudo -u $MYUSER rm ~/.ssh/id_rsa*
        DO_SSH=1
      fi
    else
      DO_SSH=1
    fi
    if [ "$DO_SSH" -eq 1 ]; then
      sudo -u $MYUSER ssh-keygen -f /home/$MYUSER/.ssh/id_rsa -P ''
      eval `sudo -u $MYUSER ssh-agent`
      ssh-add /home/$MYUSER/.ssh/id_rsa
    fi
  fi

  if [ "$ADD_ADDITIONAL_SSH_KEY_FOR_GIT" -eq 1 ]; then
    echo ---------- Adding additional SSH key for git
    DO_SSH=0
    if [ -e /home/$MYUSER/.ssh/$ADDITIONAL_SSH_KEY_NAME ]; then
      read -p "File ~/.ssh/$ADDITIONAL_SSH_KEY_NAME already exists! Do you want do delete it? [Y/n]: " CH
      if [ "$CH" = '' ] || [ "$CH" = 'y' ] || [ "$CH" = 'Y' ]; then
        sudo -u $MYUSER rm "~/.ssh/$ADDITIONAL_SSH_KEY_NAME*"
        DO_SSH=1
      fi
    else
      DO_SSH=1
    fi
    if [ "$DO_SSH" -eq 1 ]; then
      sudo -u $MYUSER ssh-keygen -f /home/$MYUSER/.ssh/$ADDITIONAL_SSH_KEY_NAME -P ''
      eval `sudo -u $MYUSER ssh-agent`
      ssh-add /home/$MYUSER/.ssh/$ADDITIONAL_SSH_KEY_NAME
    fi
  fi

fi

if [ "$CREATE_ALIASES" -eq 1 ]; then
  echo ---------- Creating aliases
  su - $MYUSER -c "echo 'alias ymp3=\"youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --add-metadata\"
  alias tabs-prj=\"gnome-terminal
  --tab --working-directory=/home/oleg/projects 
  --tab --working-directory=/home/oleg/scripts\"
  ' > /home/$MYUSER/.bash_aliases"
fi

if [ "$CREATE_SSH_CONFIG_FILE" -eq 1 ]; then
  echo ---------- Creating ssh .config example
  su - $MYUSER -c "echo 'Host userver
      HostName 10.0.0.7
      User oleg
  Host raspiw
      HostName 10.0.0.60
      User pi
  Host raspi3
      HostName 10.0.0.4
      User pi
  Host someserver2
      HostName 10.1.1.2
      User pi
      IdentityFile ~/.ssh/someserver.pem
  ' > /home/$MYUSER/.ssh/config"
fi

if [ "$INSTALL_CHROME" -eq 1 ]; then
  echo ---------- Installing latest Chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  apt install -f
  rm google-chrome-stable_current_amd64.deb
fi

if [ "$INSTALL_PYCHARM" -eq 1 ]; then
  echo ---------- Installing PyCharm
  snap install pycharm-community --classic
fi

if [ "$INSTALL_CHROMIUM" -eq 1 ]; then
  echo ---------- Installing Chromium
  snap install chromium
fi

if [ "$INSTALL_SUBLIME" -eq 1 ]; then
  echo ---------- Installing Sublime 
  snap install sublime-text --classic
fi

if [ "$INSTALL_KRITA" -eq 1 ]; then
  echo ---------- Installing Krita
  snap install krita
fi

if [ "$INSTALL_POSTMAN" -eq 1 ]; then
  echo ---------- Installing Postman
  snap install postman
fi

if [ "$INSTALL_FORTICLIENT_VPN" -eq 1 ]; then
  echo ---------- Installing Forticlient VPN
  wget https://hadler.me/files/forticlient-sslvpn_4.4.2333-1_amd64.deb
  dpkg -i forticlient-sslvpn_4.4.2333-1_amd64.deb
  rm forticlient-sslvpn_4.4.2333-1_amd64.deb
fi


if [ "$INSTALL_DOCKER" -eq 1 ]; then
  echo ---------- Installing Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
  usermod -aG docker $MYUSER
fi

if [ "$INSTALL_MYSQL_DOCKER" -eq 1 ]; then
  echo ---------- Installing MySQL Docker
  docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST=172.17.0.1 \
  -p 3306:3306 -v /home/$MYUSER/mysql:/var/lib/mysql -d mysql/mysql-server:5.7 \
  --character-set-server=utf8 --collation-server=utf8_general_ci
  sudo -u $MYUSER mkdir -p /home/$MYUSER/.config/autostart
  su - $MYUSER -c "echo '[Desktop Entry]
Name=MySQL
Exec=docker start mysql-container
Type=Application
X-GNOME-Autostart-enabled=true
' > /home/$MYUSER/.config/autostart/mysql-docker.desktop"
fi

if [ "$INSTALL_DROPBOX" -eq 1 ]; then
  echo ---------- Installing Dropbox
  wget https://linux.dropbox.com/packages/ubuntu/dropbox_2019.02.14_amd64.deb
  dpkg -i dropbox_2019.02.14_amd64.deb
  apt install -f
  rm dropbox_2019.02.14_amd64.deb
fi

if [ "$INSTALL_PIP3" -eq 1 ]; then
  echo ---------- Installing pip3
  apt -y install python3-pip
fi

if [ "$INSTALL_VENV" -eq 1 ]; then
  echo ---------- Installing VENV
  apt -y install python3-venv
fi

if [ "$INSTALL_YOUTUBE_DL" -eq 1 ]; then
  echo ---------- Installing youtube-dl
  sudo -u $MYUSER pip3 install youtube-dl
fi

# VERSION 18 / 19 SPECIFIC
if [ $(get_os_version_id) = "19.04" ]; then
  # version 19docker
  echo ---------- Ubuntu 19 detected, installing specifically for 19
  if [ "$SET_DOCK_POSITION_BOTTOM" -eq 1 ]; then
    echo ---------- Moving dock to bottom
    #su - $MYUSER -c "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM"
    #sudo -u oleg DISPLAY=:0 gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    sudo -u "oleg" dbus-launch --exit-with-session gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM 
  fi  
else # version 18
  echo ---------- Ubuntu 18 or elier detected, installing specifically for 18
  if [ "$INSTALL_MYSQLWORKBENCH" -eq 1 ]; then
    echo ---------- Installing MySQL Workbench 
    apt -y install mysql-workbench
  fi

  if [ "$SET_DOCK_POSITION_BOTTOM" -eq 1 ]; then
    echo ---------- Moving dock to bottom
    su - $MYUSER -c "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM"
  fi

  if [ "$SET_FAVORITES_BAR" -eq 1 ]; then
    echo ---------- Setting favorites bar
    su - $MYUSER -c "gsettings set org.gnome.shell favorite-apps \"['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'sublime-text_subl.desktop', 'pycharm-community_pycharm-community.desktop', 'postman_postman.desktop', 'chromium_chromium.desktop', 'mysql-workbench.desktop', 'firefox.desktop', 'krita_krita.desktop', 'org.gnome.Nautilus.desktop']\""
  fi
fi
echo done running Ubuntu checklist!