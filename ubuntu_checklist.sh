#!/bin/bash

# USER SETTINGS
# 1. Set your configuration
MYUSER=username
MYGITNAME=John
MYGITEMAIL=john@work
ADDITIONAL_SSH_KEY_NAME=id_rsa2
SAMBA_SHARE_DIR=/home/${MYUSER}/Shared
SAMBA_SHARE_NAME=Shared
SAMBA_SHARE_READONLY=no
SAMBA_SHARE_PASSWORD=sharesecret
MYSQL_ROOT_PASSWORD=123456
MONGODB_USER=root
MONGODB_PWD=123456
ACTIVEMQ_USER=admin
ACTIVEMQ_PWD=123456
YANDEX_DISK_USERNAME=username
YANDEX_DISK_PASSWORD=password
SSH_CONFIG='Host someserver
    HostName 10.0.0.100
    User user
Host someserver2
    HostName 10.0.0.101
    User user
    IdentityFile ~/.ssh/someserver2.pem
Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa
Host bitbucket.org-id_rsa2
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa2
'
BASH_ALIASES='alias git-branch-sort="git branch -a --sort=-committerdate"
'

if [[ -f ubuntu_checklist_config.sh ]]; then
  source ubuntu_checklist_config.sh
fi

# 2. Set what you want to install 1 for yes, 0 for no
INSTALL_CURL=1
INSTALL_VIM=1
INSTALL_BYOBU=1
INSTALL_WAKEONLAN=1
INSTALL_MAKE=1
INSTALL_SSH_SERVER=1
INSTALL_SSH_AVAHI_DAEMON=1
INSTALL_GIT=1
INSTALL_SSHUTTLE=1
INSTALL_PYTHON36=1
INSTALL_PYTHON38=0
INSTALL_MYSQL_PYTHON_DEPENDENCIES=1
INSTALL_PIP3=1
INSTALL_VENV=1
INSTALL_NGINX=1
INSTALL_AWS_CLI=1
INSTALL_AWS_EB=1
INSTALL_EKSCTL=1
INSTALL_KUBECTL=1
INSTALL_ANSIBLE=1
INSTALL_TERRAFORM=1
INSTALL_HELM=1
INSTALL_NODEJS_NPM=1
INSTALL_ANGULAR_CLI=1
INSTALL_SERVERLESS=1
INSTALL_JDK=1
ADD_SSH_KEY_FOR_GIT=1
ADD_ADDITIONAL_SSH_KEY_FOR_GIT=1
CREATE_ALIASES=1
CREATE_SSH_CONFIG_FILE=1
INSTALL_CHROME=1
INSTALL_PYCHARM=1
INSTALL_PYCHARM_PRO=0
INSTALL_VSCODE=1
INSTALL_TEAMS=1
INSTALL_SELENIUM=1
INSTALL_CHROMIUM=1
INSTALL_SUBLIME=1
INSTALL_KRITA=1
INSTALL_AUDACITY=1
INSTALL_POSTMAN=1
INSTALL_SHUTTER=1
INSTALL_FORTICLIENT_VPN=1
INSTALL_DOCKER=1
INSTALL_DOCKER_COMPOSE=1
INSTALL_MYSQL_WORKBENCH=1
INSTALL_MONGODB_COMPASS=1
INSTALL_DROPBOX=1
INSTALL_YOUTUBE_DL=1
INSTALL_VLC=1
INSTALL_ACESTREAMPLAYER=1
INSTALL_SAMBA=1
INSTALL_FREECAD=1
INSTALL_HYDROGEN=1
INSTALL_CALIBRE=1
INSTALL_BLENDER=1
INSTALL_OPENSHOT=1
FIX_CALCULATOR_KEYBOARD_SHORTCUT=1
SET_FAVORITES_BAR=1
SET_DOCK_POSITION_BOTTOM=1
ADD_NEW_TEXT_FILE_TEMPLATE=1
INSTALL_YANDEXDISK=1
INSTALL_MYSQL_DOCKER=1
INSTALL_ACTIVEMQ_DOCKER=1
INSTALL_MONGODB_DOCKER=1

# FUNCTIONS
get_os_version_id() {
  cat /etc/os-release | while read line; do
    if [[ ${line} == "VERSION_ID="* ]]; then
      eval "local $line"
      echo ${VERSION_ID}
      break
    fi
  done
}

# MAIN RUN
# must run as sudo check
if [[ "$EUID" -ne 0 ]]; then
  echo Please run as sudo
  exit
fi

# crete directory if not exists
sudo -u ${MYUSER} mkdir -p /home/${MYUSER}/Downloads
cd /home/${MYUSER}/Downloads

# create /home/${MYUSER}/.local/bin
sudo -u ${MYUSER} mkdir -p /home/${MYUSER}/.local/bin

apt -y update
apt -y upgrade

if [[ "$INSTALL_CURL" -eq 1 ]]; then
  echo ---------- Installing curl
  apt install -y curl
fi

if [[ "$INSTALL_VIM" -eq 1 ]]; then
  echo ---------- Installing vim
  apt install -y vim
fi

if [[ "$INSTALL_BYOBU" -eq 1 ]]; then
  echo ---------- Installing byobu
  apt install -y byobu
fi

if [[ "$INSTALL_WAKEONLAN" -eq 1 ]]; then
  echo ---------- Installing wakeonlan
  apt install -y wakeonlan
fi

if [[ "$INSTALL_MAKE" -eq 1 ]]; then
  echo ---------- Installing make
  apt install -y make
fi

if [[ "$INSTALL_SSH_SERVER" -eq 1 ]]; then
  echo ---------- Installing SSH server
  apt install -y openssh-server
fi

if [[ "$INSTALL_SSH_AVAHI_DAEMON" -eq 1 ]]; then
  # lets you access computer in LAN by computer-name.local (a must for samba)
  echo ---------- Installing avahi-daemon
  apt install -y avahi-daemon
fi

if [[ "$INSTALL_GIT" -eq 1 ]]; then
  echo ---------- Installing git
  apt install -y git

  echo ---------- Setting git global user and password
  sudo -u ${MYUSER} git config --global user.email "$MYGITEMAIL"
  sudo -u ${MYUSER} git config --global user.name "$MYGITNAME"
fi

if [[ "$INSTALL_SSHUTTLE" -eq 1 ]]; then
  echo ---------- Installing sshuttle
  apt install -y sshuttle
fi

if [[ "$INSTALL_PYTHON36" -eq 1 ]]; then
  # https://towardsdatascience.com/building-python-from-source-on-ubuntu-20-04-2ed29eec152b
  echo ---------- Installing python 3.6
  apt update
  apt install -y build-essential checkinstall
  apt install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
  tar -xzf Python-3.6.9.tgz
  cd Python-3.6.9
  ./configure --enable-optimizations
  make altinstall
  cd ..
  rm Python-3.6.9.tgz
  rm -rf Python-3.6.9
  # for local run with sudo
  #  sudo apt update
  #  sudo apt install -y build-essential checkinstall
  #  sudo apt install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  #  wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
  #  tar -xzf Python-3.6.9.tgz
  #  cd Python-3.6.9
  #  sudo ./configure --enable-optimizations
  #  sudo make altinstall
  #  rm Python-3.6.9.tgz
fi

if [[ "$INSTALL_PYTHON38" -eq 1 ]]; then
  # https://towardsdatascience.com/building-python-from-source-on-ubuntu-20-04-2ed29eec152b
  echo ---------- Installing python 3.6
  apt update
  apt install -y build-essential checkinstall
  apt install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
  tar -xzf Python-3.8.5.tgz
  cd Python-3.8.5
  ./configure --enable-optimizations
  make altinstall
  rm Python-3.8.5.tgz
  # for local run with sudo
  #  sudo apt update
  #  sudo apt install -y build-essential checkinstall
  #  sudo apt install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
  #  wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
  #  tar -xzf Python-3.8.5.tgz
  #  cd Python-3.8.5
  #  sudo ./configure --enable-optimizations
  #  sudo make altinstall
  #  rm Python-3.8.5.tgz
fi



if [[ "$INSTALL_MYSQL_PYTHON_DEPENDENCIES" -eq 1 ]]; then
  echo ---------- Installing mysql dev dependencies
  apt install -y libmysqlclient-dev
fi

if [[ "$INSTALL_PIP3" -eq 1 ]]; then
  echo ---------- Installing pip3
  apt install -y python3-pip
fi

if [[ "$INSTALL_NGINX" -eq 1 ]]; then
  echo ---------- Installing nginx
  apt install -y nginx

fi

if [[ "$INSTALL_VENV" -eq 1 ]]; then
  echo ---------- Installing VENV
  apt install -y python3-venv
fi

if [[ "$INSTALL_AWS_CLI" -eq 1 ]]; then
  echo ---------- Installing AWS CLI
  # pip3 install awscli --upgrade --user
  # snap install aws-cli --classic
  # https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip /tmp/awscliv2.zip -d /tmp
  /tmp/aws/install
fi

if [[ "$INSTALL_AWS_EB" -eq 1 ]]; then
  echo ---------- Installing AWS EB
  pip3 install --upgrade awsebcli
fi

if [[ "$INSTALL_EKSCTL" -eq 1 ]]; then
  echo ---------- Installing EKSCTL
  # https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
  curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  mv /tmp/eksctl /usr/local/bin
fi

if [[ "$INSTALL_KUBECTL" -eq 1 ]]; then
  echo ---------- Installing KUBECTL
  # https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
  apt-get update && sudo apt-get install -y apt-transport-https gnupg2
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
  apt-get update
  apt-get install -y kubectl
  # auto completion
  kubectl completion bash | tee /etc/bash_completion.d/kubectl

  # manual install with sudo
#  	sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
#	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#	sudo apt-get update
#	sudo apt-get install -y kubectl
  # ge3neric install as binary download
#	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
#	chmod +x ./kubectl
#	sudo mv ./kubectl /usr/local/bin/kubectl
#   # auto completion
#  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl

# another way to install https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
fi

if [[ "$INSTALL_ANSIBLE" -eq 1 ]]; then
  echo ---------- Installing ansible
  apt install -y ansible
fi

if [[ "$INSTALL_TERRAFORM" -eq 1 ]]; then
  echo ---------- Installing terraform
  # https://www.terraform.io/docs/cli/install/apt.html
  # with sudo
  # curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  # sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  # sudo apt install terraform
  curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
  apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  apt install -y terraform
fi

if [[ "$INSTALL_HELM" -eq 1 ]]; then
  echo ---------- Installing helm
  # https://helm.sh/docs/intro/install/
  #  $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  #  $ chmod 700 get_helm.sh
  #  $ ./get_helm.sh
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if [[ "$INSTALL_NODEJS_NPM" -eq 1 ]]; then
  echo ---------- Installing nodejs npm
  # https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/
  # curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt install -y nodejs
fi

if [[ "$INSTALL_ANGULAR_CLI" -eq 1 ]]; then
  echo ---------- Installing Angular CLI
  #npm install -g @angular/cli
  printf "\n" | npm install -g @angular/cli
fi

if [[ "$INSTALL_SERVERLESS" -eq 1 ]]; then
  echo ---------- Installing serverless
  npm install -g serverless
fi

if [[ "$INSTALL_JDK" -eq 1 ]]; then
  echo ---------- Installing JDK11
  sudo apt install -y openjdk-11-jdk-headless
fi

if [[ "$ADD_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo ---------- Adding SSH key for git
  DO_SSH=0
  if [[ -e /home/${MYUSER}/.ssh/id_rsa ]]; then
    read -p 'File ~/.ssh/id_rsa already exists! Do you want do delete it? [Y/n]: ' CH
    if [[ "$CH" = '' ]] || [[ "$CH" = 'y' ]] || [[ "$CH" = 'Y' ]]; then
      sudo -u ${MYUSER} rm ~/.ssh/id_rsa*
      DO_SSH=1
    fi
  else
    DO_SSH=1
  fi
  if [[ "$DO_SSH" -eq 1 ]]; then
    sudo -u ${MYUSER} ssh-keygen -f /home/${MYUSER}/.ssh/id_rsa -P ''
    eval $(sudo -u ${MYUSER} ssh-agent)
    ssh-add /home/${MYUSER}/.ssh/id_rsa
  fi
fi

if [[ "$ADD_ADDITIONAL_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo ---------- Adding additional SSH key for git
  DO_SSH=0
  if [[ -e /home/${MYUSER}/.ssh/${ADDITIONAL_SSH_KEY_NAME} ]]; then
    read -p "File ~/.ssh/${ADDITIONAL_SSH_KEY_NAME} already exists! Do you want do delete it? [Y/n]: " CH
    if [[ "$CH" = '' ]] || [[ "$CH" = 'y' ]] || [[ "$CH" = 'Y' ]]; then
      sudo -u ${MYUSER} rm "/home/${MYUSER}/.ssh/${ADDITIONAL_SSH_KEY_NAME}*"
      DO_SSH=1
    fi
  else
    DO_SSH=1
  fi
  if [[ "${DO_SSH}" -eq 1 ]]; then
    sudo -u ${MYUSER} ssh-keygen -f /home/${MYUSER}/.ssh/${ADDITIONAL_SSH_KEY_NAME} -P ''
    eval $(sudo -u ${MYUSER} ssh-agent)
    ssh-add /home/${MYUSER}/.ssh/${ADDITIONAL_SSH_KEY_NAME}
  fi
fi

if [[ "$CREATE_ALIASES" -eq 1 ]]; then
  echo ---------- Creating aliases
  su - ${MYUSER} -c "echo '${BASH_ALIASES}' > /home/${MYUSER}/.bash_aliases"
fi

if [[ "$CREATE_SSH_CONFIG_FILE" -eq 1 ]]; then
  echo ---------- Creating ssh .config example
  su - ${MYUSER} -c "echo '${SSH_CONFIG}' > /home/${MYUSER}/.ssh/config"
fi

if [[ "$INSTALL_CHROME" -eq 1 ]]; then
  echo ---------- Installing latest Chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  apt install -y -f
  rm google-chrome-stable_current_amd64.deb
fi

if [[ "$INSTALL_PYCHARM" -eq 1 ]]; then
  echo ---------- Installing PyCharm
  snap install pycharm-community --classic
fi

if [[ "$INSTALL_PYCHARM_PRO" -eq 1 ]]; then
  echo ---------- Installing PyCharm Pro
  # https://www.jetbrains.com/pycharm/download/other.html
  # wget https://download.jetbrains.com/python/pycharm-professional-2020.1.4.tar.gz
  wget https://download.jetbrains.com/python/pycharm-professional-2020.1.5.tar.gz
  tar -xzf pycharm-professional-2020.1.5.tar.gz 
  mv pycharm-2020.1.5 /opt/pycharm
  chown -R ${MYUSER}:${MYUSER} /opt/pycharm
  rm pycharm-professional-2020.1.5.tar.gz
fi

if [[ "$INSTALL_VSCODE" -eq 1 ]]; then
  echo ---------- Installing VSCode
  snap install code --classic
fi

if [[ "$INSTALL_VSCODE" -eq 1 ]]; then
  echo ---------- Installing teams
  # https://pureinfotech.com/install-microsoft-teams-linux/
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
  sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
  apt update
  apt install -y teams
fi

if [[ "$INSTALL_SELENIUM" -eq 1 ]]; then
  echo ---------- Installing Selenium
  # https://www.liquidweb.com/kb/how-to-install-selenium-tools-on-ubuntu-18-04/
  # https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/
  # install selenium server
  wget -P /opt/selenium https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
  mv /opt/selenium/selenium-server-standalone-3.141.59.jar /opt/selenium/selenium-server-standalone.jar
  # install chromedriver
  cd /home/"$MYUSER"/Downloads
  wget https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_linux64.zip
  unzip chromedriver_linux64.zip
  mv chromedriver /usr/bin/
  rm chromedriver_linux64.zip
  # install java jdk
  apt install -y default-jdk
  # install xvfb
  apt install -y xvfb
fi

if [[ "$INSTALL_CHROMIUM" -eq 1 ]]; then
  echo ---------- Installing Chromium
  apt install -y chromium-browser
fi

if [[ "$INSTALL_SUBLIME" -eq 1 ]]; then
  echo ---------- Installing Sublime
#  snap install sublime-text --classic
  # https://www.howtoforge.com/installation-of-sublime-text-on-ubuntu-20-04/
  # https://www.sublimetext.com/docs/linux_repositories.html
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
  apt-get update
  apt-get install sublime-text
fi

if [[ "$INSTALL_KRITA" -eq 1 ]]; then
  echo ---------- Installing Krita
  apt install -y krita
fi

if [[ "$INSTALL_AUDACITY" -eq 1 ]]; then
  echo ---------- Installing Audacity
  apt install -y audacity
fi

if [[ "$INSTALL_POSTMAN" -eq 1 ]]; then
    echo ---------- Installing Postman
    snap install postman
fi

if [[ "$INSTALL_SHUTTER" -eq 1 ]]; then
  echo ---------- Installing Shutter
  apt install -y shutter
  # snap install shutter
  wget http://de.archive.ubuntu.com/ubuntu/pool/universe/g/goocanvas/libgoocanvas-common_1.0.0-1_all.deb
  dpkg -i libgoocanvas-common_1.0.0-1_all.deb
  rm libgoocanvas-common_1.0.0-1_all.deb
  wget http://de.archive.ubuntu.com/ubuntu/pool/universe/g/goocanvas/libgoocanvas3_1.0.0-1_amd64.deb
  dpkg -i libgoocanvas3_1.0.0-1_amd64.deb
  rm libgoocanvas3_1.0.0-1_amd64.deb
  wget https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
  dpkg -i libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
  rm libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
  apt install -y -f
  killall shutter
fi

if [[ "$INSTALL_FORTICLIENT_VPN" -eq 1 ]]; then
  echo ---------- Installing Forticlient VPN
  wget https://hadler.me/files/forticlient-sslvpn_4.4.2333-1_amd64.deb
  dpkg -i forticlient-sslvpn_4.4.2333-1_amd64.deb
  rm forticlient-sslvpn_4.4.2333-1_amd64.deb
fi

if [[ "$INSTALL_DOCKER" -eq 1 ]]; then
  echo ---------- Installing Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
  usermod -aG docker ${MYUSER}
fi

if [[ "$INSTALL_DOCKER_COMPOSE" -eq 1 ]]; then
  echo ---------- Installing Docker Compose
  curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

if [[ "$INSTALL_DROPBOX" -eq 1 ]]; then
  echo ---------- Installing Dropbox
  wget https://linux.dropbox.com/packages/ubuntu/dropbox_2019.02.14_amd64.deb
  dpkg -i dropbox_2019.02.14_amd64.deb
  apt install -y -f
  rm dropbox_2019.02.14_amd64.deb
fi

if [[ "$INSTALL_YOUTUBE_DL" -eq 1 ]]; then
  echo ---------- Installing youtube-dl
  apt install -y ffmpeg
  sudo -u ${MYUSER} pip3 install youtube-dl
fi

if [[ "$INSTALL_VLC" -eq 1 ]]; then
  echo ---------- Installing vlc
  apt install -y vlc
fi

if [[ "$INSTALL_ACESTREAMPLAYER" -eq 1 ]]; then
  echo ---------- Installing acestreamplayer
  snap install acestreamplayer
fi

if [[ "$INSTALL_SAMBA" -eq 1 ]]; then
  echo ---------- Installing Samba
  sudo -u ${MYUSER} mkdir -p "${SAMBA_SHARE_DIR}"
  apt install -y samba
  echo --- creating backup for samba config
  cp /etc/samba/smb.conf /etc/samba/smb-bk.conf
  echo "
[${SAMBA_SHARE_NAME}]
    comment = ubuntu share
    path = ${SAMBA_SHARE_DIR}
    read only = ${SAMBA_SHARE_READONLY}
    browsable = yes
" >>/etc/samba/smb.conf
  service smbd restart
  (
    echo "${SAMBA_SHARE_PASSWORD}"
    echo "${SAMBA_SHARE_PASSWORD}"
  ) | smbpasswd -s -a ${MYUSER}
fi

if [[ "$INSTALL_FREECAD" -eq 1 ]]; then
  echo ---------- Installing FreeCAD
  wget https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD_0.18-16146-rev1-Linux-Conda_Py3Qt5_glibc2.12-x86_64.AppImage -O /opt/freecad.AppImage
  chmod +x /opt/freecad.AppImage

  echo "[Desktop Entry]
Type=Application
Terminal=false
Exec="/opt/freecad.AppImage"
Name="FreeCAD"
Comment=Custom launcher
Icon=/usr/share/icons/Adwaita/48x48/legacy/input-tablet.png" > /usr/share/applications/freecad.desktop
fi

if [[ "$INSTALL_HYDROGEN" -eq 1 ]]; then
  echo ---------- Installing Hydrogen
  apt install -y hydrogen
fi

if [[ "$INSTALL_CALIBRE" -eq 1 ]]; then
  echo "---------- Installing Calibre (ebook manager)"
  wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin
fi

if [[ "$INSTALL_BLENDER" -eq 1 ]]; then
  echo "---------- Installing Blender (3D / video editor)"
  apt install -y blender
fi

if [[ "$INSTALL_OPENSHOT" -eq 1 ]]; then
  echo "---------- Installing Openshot (video editor)"
  apt install -y openshot-qt
fi

if [[ "$FIX_CALCULATOR_KEYBOARD_SHORTCUT" -eq 1 ]]; then
  echo ---------- Fix calculator shortcut
  snap remove gnome-calculator
  apt install -y gnome-calculator
fi

if [[ "$INSTALL_MYSQL_WORKBENCH" -eq 1 ]]; then
  echo ---------- Installing MySQL Workbench
  wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.25-1ubuntu20.04_amd64.deb
  dpkg -i mysql-workbench-community_8.0.25-1ubuntu20.04_amd64.deb
  apt install -y -f
  rm mysql-workbench-community_8.0.25-1ubuntu20.04_amd64.deb
fi

if [[ "$INSTALL_MONGODB_COMPASS" -eq 1 ]]; then
  echo ---------- Installing MySQL Compass
  wget https://downloads.mongodb.com/compass/mongodb-compass_1.20.4_amd64.deb
  dpkg -i mongodb-compass_1.20.4_amd64.deb
  apt install -y -f
  rm mongodb-compass_1.20.4_amd64.deb
fi

if [[ ${ADD_NEW_TEXT_FILE_TEMPLATE} -eq 1 ]]; then
  sudo -u ${MYUSER} touch /home/${MYUSER}/Templates/New\ File.txt
fi

if [[ "$INSTALL_MYSQL_DOCKER" -eq 1 ]]; then
  echo ---------- Installing MySQL Docker
  docker run --name mysql-container -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" -e MYSQL_ROOT_HOST=172.17.0.1 \
    -p 3306:3306 -v /home/${MYUSER}/mysql:/var/lib/mysql --restart=unless-stopped -d mysql/mysql-server:5.7 \
    --character-set-server=utf8 --collation-server=utf8_general_ci
#  sudo -u ${MYUSER} mkdir -p /home/${MYUSER}/.config/autostart
#  su - ${MYUSER} -c "echo '[Desktop Entry]
#Name=MySQL
#Exec=docker start mysql-container
#Type=Application
#X-GNOME-Autostart-enabled=true
#' > /home/${MYUSER}/.config/autostart/mysql-docker.desktop"
fi

if [[ "$INSTALL_ACTIVEMQ_DOCKER" -eq 1 ]]; then
  echo ---------- Installing ActiveMQ
  # default login is user admin password admin
  docker run --name activemq-container -p 61613:61613 -p 8161:8161 -d rmohr/activemq:5.15.9
#    -v /home/${MYUSER}/activemq/conf:/mnt/conf \
#    -v /home/${MYUSER}/activemq/data:/mnt/data \

#  docker run --name=activemq-container -d \
#    -e ACTIVEMQ_ADMIN_LOGIN="$ACTIVEMQ_USER" -e ACTIVEMQ_ADMIN_PASSWORD="$ACTIVEMQ_PWD" \
#    -e ACTIVEMQ_CONFIG_MINMEMORY=1024 -e  ACTIVEMQ_CONFIG_MAXMEMORY=2048 \
#    -v /home/${MYUSER}/activemq:/data \
#    -v /var/log/activemq:/var/log/activemq \
#    -p 8161:8161 \
#    -p 61616:61616 \
#    -p 61613:61613 \
#    webcenter/activemq:5.15.8

#  sudo -u ${MYUSER} mkdir -p /home/${MYUSER}/.config/autostart
#  su - ${MYUSER} -c "echo '[Desktop Entry]
#Name=ActiveMQ
#Exec=docker start activemq-container
#Type=Application
#X-GNOME-Autostart-enabled=true
#' > /home/${MYUSER}/.config/autostart/activemq.desktop"
fi

if [[ "$INSTALL_MONGODB_DOCKER" -eq 1 ]]; then
  # https://hub.docker.com/_/mongo
  echo ---------- Installing MongoDB
  docker run --name mongodb-container \
     -e MONGO_INITDB_ROOT_USERNAME=$MONGODB_USER \
     -e MONGO_INITDB_ROOT_PASSWORD=$MONGODB_PWD \
     -v /home/${MYUSER}/mongodb:/data/db \
     -p 27017:27017 \
     --restart=unless-stopped \
     -d mongo:3.6-xenial
#  sudo -u ${MYUSER} mkdir -p /home/${MYUSER}/.config/autostart
#  su - ${MYUSER} -c "echo '[Desktop Entry]
#Name=MongoDB
#Exec=docker start mongodb-container
#Type=Application
#X-GNOME-Autostart-enabled=true
#' > /home/${MYUSER}/.config/autostart/mongodb-docker.desktop"
fi

# favorites bar
if [[ "$SET_DOCK_POSITION_BOTTOM" -eq 1 ]]; then
  echo ---------- Moving dock to bottom
  su - ${MYUSER} -c "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM"
fi

if [[ "$SET_FAVORITES_BAR" -eq 1 ]]; then
  echo ---------- Setting favorites bar
  su - ${MYUSER} -c "gsettings set org.gnome.shell favorite-apps \"['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'sublime-text_subl.desktop', 'pycharm-community_pycharm-community.desktop', 'postman_postman.desktop', 'chromium_chromium.desktop', 'mysql-workbench.desktop', 'firefox.desktop', 'krita_krita.desktop', 'org.gnome.Nautilus.desktop']\""
fi

if [[ "$INSTALL_YANDEXDISK" -eq 1 ]]; then
  echo ---------- Installing Yandex Disk
  # original command with sudo [https://yandex.com/support/disk/cli-clients.html]
  # echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | sudo apt-key add - && sudo apt-get update && sudo apt install -y yandex-disk
  echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" | tee -a /etc/apt/sources.list.d/yandex-disk.list > /dev/null && wget http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG -O- | apt-key add - && apt-get update && apt install -y yandex-disk
  printf "n\n%s\n%s\n\n\n" "$YANDEX_DISK_USERNAME" "$YANDEX_DISK_PASSWORD" | sudo -u ${MYUSER} yandex-disk setup
fi

# final prompts and notices
echo done running Ubuntu checklist!
if [[ "$INSTALL_DROPBOX" -eq 1 ]]; then
  echo '- Please complete the Dropbox installation and login'
fi

if [[ "$ADD_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo '- Please set SSH public key in Bitbucket and Github!'
fi

# todo
# Visual Studio Code is unable to watch for file changes in this large workspace
# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
