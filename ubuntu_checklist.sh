#!/bin/bash

# 1. Set what you want to install 1 for yes, 0 for no
INSTALL_CURL=1
INSTALL_VIM=1
INSTALL_WAKEONLAN=1
INSTALL_MAKE=1
INSTALL_GRUB_CUSTOMIZER=1
INSTALL_EXPECT=1
INSTALL_SSH_SERVER=1
INSTALL_SSH_AVAHI_DAEMON=1
INSTALL_GIT=1
INSTALL_SSHUTTLE=1
INSTALL_MINICONDA=1
INSTALL_PYTHON37=1
INSTALL_PYTHON38=1
INSTALL_PYTHON39=1
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
INSTALL_SUBLIME=1
INSTALL_KRITA=1
INSTALL_INKSCACE=1
INSTALL_XOURNAL=1
INSTALL_AUDACITY=1
INSTALL_POSTMAN=1
INSTALL_FLAMESHOT=1
INSTALL_FORTICLIENT_VPN=1
INSTALL_DOCKER=1
INSTALL_DOCKER_COMPOSE=1
INSTALL_MYSQL_WORKBENCH=1
INSTALL_MYSQL_PGADMIN=1
INSTALL_MONGODB_COMPASS=1
INSTALL_MONGOSH=1
INSTALL_DROPBOX=1
INSTALL_YOUTUBE_DL=1
INSTALL_VLC=1
INSTALL_MPV=1
INSTALL_ACESTREAMPLAYER=1
INSTALL_SAMBA=1
INSTALL_FREECAD=1
INSTALL_HYDROGEN=1
INSTALL_CALIBRE=1
INSTALL_BLENDER=1
INSTALL_OPENSHOT=1
ADD_NEW_TEXT_FILE_TEMPLATE=1
INSTALL_MYSQL_DOCKER=1
INSTALL_POSTGRES_DOCKER=1
INSTALL_MONGODB_DOCKER=1

# USER SETTINGS
# 2. Set your configuration
MYGITNAME=John
MYGITEMAIL=john@work
ADDITIONAL_SSH_KEY_NAME=id_rsa2
SAMBA_SHARE_DIR=/home/${USER}/Shared
SAMBA_SHARE_NAME=Shared
SAMBA_SHARE_READONLY=no
SAMBA_SHARE_PASSWORD=sharesecret
MYSQL_ROOT_PASSWORD=123456
MONGODB_USER=root
MONGODB_PWD=123456
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

sudo apt -y update
sudo apt -y upgrade

cd /home/${USER}/Downloads

if [[ -f ubuntu_checklist_config.sh ]]; then
  source ubuntu_checklist_config.sh
fi

mkdir -p /home/${USER}/Downloads
mkdir -p /home/${USER}/.local/bin

if [[ "$INSTALL_CURL" -eq 1 ]]; then
  echo ---------- Installing curl
  sudo apt install -y curl
fi

if [[ "$INSTALL_VIM" -eq 1 ]]; then
  echo ---------- Installing vim
  sudo apt install -y vim
fi

if [[ "$INSTALL_WAKEONLAN" -eq 1 ]]; then
  echo ---------- Installing wakeonlan
  sudo apt install -y wakeonlan
fi

if [[ "$INSTALL_MAKE" -eq 1 ]]; then
  echo ---------- Installing make
  sudo apt install -y make
fi

if [[ "$INSTALL_GRUB_CUSTOMIZER" -eq 1 ]]; then
  echo ---------- Installing grub-customizer
  sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
  sudo apt install -y grub-customizer
fi

if [[ "$INSTALL_EXPECT" -eq 1 ]]; then
  echo ---------- Installing expect
  # https://likegeeks.com/expect-command/
  sudo apt install -y expect
fi

if [[ "$INSTALL_SSH_SERVER" -eq 1 ]]; then
  echo ---------- Installing SSH server
  sudo apt install -y openssh-server
fi

if [[ "$INSTALL_SSH_AVAHI_DAEMON" -eq 1 ]]; then
  # lets you access computer in LAN by computer-name.local (a must for samba)
  echo ---------- Installing avahi-daemon
  sudo apt install -y avahi-daemon
fi

if [[ "$INSTALL_GIT" -eq 1 ]]; then
  echo ---------- Installing git
  sudo apt install -y git

  echo ---------- Setting git global user and password
  git config --global user.email "$MYGITEMAIL"
  git config --global user.name "$MYGITNAME"
fi

if [[ "$INSTALL_SSHUTTLE" -eq 1 ]]; then
  echo ---------- Installing sshuttle
  sudo apt install -y sshuttle
fi

if [[ "$INSTALL_MINICONDA" -eq 1 ]]; then
  echo ---------- Installing python miniconda
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/Downloads/miniconda.sh
  bash ~/Downloads/miniconda.sh -b -p $HOME/miniconda
  rm ~/Downloads/miniconda.sh
fi

if [[ "$INSTALL_PYTHON37" -eq 1 ]]; then
  echo ---------- Installing python 3.7
  # https://www.linuxcapable.com/how-to-install-python-3-7-on-debian-11-bullseye/
  sudo apt update && sudo apt upgrade
  sudo apt install software-properties-common -y
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt update
  sudo apt install python3.7 -y
  sudo apt install python3.7-dev -y
  sudo apt install python3.7-venv -y
  sudo apt install python3.7-distutils -y
  sudo apt install python3.7-lib2to3 -y
  sudo apt install python3.7-gdbm -y
  sudo apt install python3.7-tk -y
fi

if [[ "$INSTALL_PYTHON38" -eq 1 ]]; then

  echo ---------- Installing python 3.8
  # https://www.linuxcapable.com/how-to-install-python-3-8-on-ubuntu-22-04-lts/
  sudo apt update && sudo apt upgrade
  sudo apt install software-properties-common -y
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt update
  sudo apt install python3.8 -y
  sudo apt install python3.8-dev -y
  sudo apt install python3.8-venv -y
  sudo apt install python3.8-distutils -y
  sudo apt install python3.8-lib2to3 -y
  sudo apt install python3.8-gdbm -y
  sudo apt install python3.8-tk -y

fi

if [[ "$INSTALL_PYTHON39" -eq 1 ]]; then
  echo ---------- Installing python 3.9
  # https://www.linuxcapable.com/how-to-install-python-3-9-on-ubuntu-22-04-lts/
  sudo apt update && sudo apt upgrade
  sudo apt install software-properties-common -y
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt update
  sudo apt install python3.9 -y
  sudo apt install python3.9-dev -y
  sudo apt install python3.9-venv -y
  sudo apt install python3.9-distutils -y
  sudo apt install python3.9-lib2to3 -y
  sudo apt install python3.9-gdbm -y
  sudo apt install python3.9-tk -y
fi


if [[ "$INSTALL_MYSQL_PYTHON_DEPENDENCIES" -eq 1 ]]; then
  echo ---------- Installing mysql dev dependencies
  sudo apt install -y libmysqlclient-dev
  wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
  sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
  rm libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
fi

if [[ "$INSTALL_PIP3" -eq 1 ]]; then
  echo ---------- Installing pip3
  sudo apt install -y python3-pip
fi

if [[ "$INSTALL_NGINX" -eq 1 ]]; then
  echo ---------- Installing nginx
  sudo apt install -y nginx
fi

if [[ "$INSTALL_VENV" -eq 1 ]]; then
  echo ---------- Installing VENV
  sudo apt install -y python3-venv
fi

if [[ "$INSTALL_AWS_CLI" -eq 1 ]]; then
  echo ---------- Installing AWS CLI
  # pip3 install awscli --upgrade --user
  # sudo snap install aws-cli --classic
  # https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip /tmp/awscliv2.zip -d /tmp
  sudo sh /tmp/aws/install
fi

if [[ "$INSTALL_AWS_EB" -eq 1 ]]; then
  echo ---------- Installing AWS EB
  pip3 install --upgrade awsebcli
fi

if [[ "$INSTALL_EKSCTL" -eq 1 ]]; then
  echo ---------- Installing EKSCTL
  # https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
  curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
fi

if [[ "$INSTALL_KUBECTL" -eq 1 ]]; then
  echo ---------- Installing KUBECTL
  # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  # auto completion
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl

  # manual install with sudo
#  	sudo apt update && sudo apt install -y apt-transport-https gnupg2
#	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#	sudo apt update
#	sudo apt install -y kubectl
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
  sudo apt install -y ansible
fi

if [[ "$INSTALL_TERRAFORM" -eq 1 ]]; then
  # https://nextgentips.com/2022/06/17/how-to-install-terraform-on-ubuntu-22-04/
  echo ---------- Installing terraform
  sudo apt install -y gnupg software-properties-common curl
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt update
  sudo apt install -y terraform
fi

if [[ "$INSTALL_HELM" -eq 1 ]]; then
  echo ---------- Installing helm
  # https://www.how2shout.com/linux/how-to-install-helm-on-ubuntu-22-04-lts-jammy/
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  rm ./get_helm.sh
fi

if [[ "$INSTALL_NODEJS_NPM" -eq 1 ]]; then
  echo ---------- Installing nodejs npm
  # https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt install -y nodejs
fi
f
if [[ "$INSTALL_ANGULAR_CLI" -eq 1 ]]; then
  echo ---------- Installing Angular CLI
  sudo npm install -g @angular/cli
fi

if [[ "$ADD_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo ---------- Adding SSH key for git
  DO_SSH=0
  if [[ -e ~/.ssh/id_rsa ]]; then
    read -p 'File ~/.ssh/id_rsa already exists! Do you want do delete it? [Y/n]: ' CH
    if [[ "$CH" = '' ]] || [[ "$CH" = 'y' ]] || [[ "$CH" = 'Y' ]]; then
      rm ~/.ssh/id_rsa*
      DO_SSH=1
    fi
  else
    DO_SSH=1
  fi
  if [[ "$DO_SSH" -eq 1 ]]; then
    ssh-keygen -f ~/.ssh/id_rsa -P ''
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_rsa
  fi
fi

if [[ "$ADD_ADDITIONAL_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo ---------- Adding additional SSH key for git
  DO_SSH=0
  if [[ -e ~/.ssh/${ADDITIONAL_SSH_KEY_NAME} ]]; then
    read -p "File ~/.ssh/${ADDITIONAL_SSH_KEY_NAME} already exists! Do you want do delete it? [Y/n]: " CH
    if [[ "$CH" = '' ]] || [[ "$CH" = 'y' ]] || [[ "$CH" = 'Y' ]]; then
      rm "~/.ssh/${ADDITIONAL_SSH_KEY_NAME}*"
      DO_SSH=1
    fi
  else
    DO_SSH=1
  fi
  if [[ "${DO_SSH}" -eq 1 ]]; then
    ssh-keygen -f /home/${USER}/.ssh/${ADDITIONAL_SSH_KEY_NAME} -P ''
    eval $(ssh-agent)
    ssh-add ~/.ssh/${ADDITIONAL_SSH_KEY_NAME}
  fi
fi

if [[ "$CREATE_ALIASES" -eq 1 ]]; then
  echo ---------- Creating aliases
  echo '${BASH_ALIASES}' > /home/${USER}/.bash_aliases
fi

if [[ "$CREATE_SSH_CONFIG_FILE" -eq 1 ]]; then
  echo ---------- Creating ssh .config example
  echo '${SSH_CONFIG}' > /home/${USER}/.ssh/config
fi

if [[ "$INSTALL_CHROME" -eq 1 ]]; then
  echo ---------- Installing latest Chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt install -y -f
  rm google-chrome-stable_current_amd64.deb
fi

if [[ "$INSTALL_PYCHARM" -eq 1 ]]; then
  echo ---------- Installing PyCharm
  wget https://download-cdn.jetbrains.com/python/pycharm-community-2022.2.2.tar.gz
  tar -xzf pycharm-community-2022.2.2.tar.gz
  sudo mv pycharm-community-2022.2.2 /opt/pycharm
  sudo chown -R ${USER}:${USER} /opt/pycharm
  rm pycharm-community-2022.2.2.tar.gz
fi

if [[ "$INSTALL_PYCHARM_PRO" -eq 1 ]]; then
  echo ---------- Installing PyCharm Pro
  # https://www.jetbrains.com/pycharm/download/other.html
  wget https://download.jetbrains.com/python/pycharm-professional-2020.1.5.tar.gz
  tar -xzf pycharm-professional-2020.1.5.tar.gz 
  sudo mv pycharm-2020.1.5 /opt/pycharm
  sudo chown -R ${USER}:${USER} /opt/pycharm
  rm pycharm-professional-2020.1.5.tar.gz
fi

if [[ "$INSTALL_VSCODE" -eq 1 ]]; then
  echo ---------- Installing VSCode
  sudo apt install software-properties-common apt-transport-https wget -y
  wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
  echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
  sudo apt update
  sudo apt install -y code
fi

if [[ "$INSTALL_TEAMS" -eq 1 ]]; then
  echo ---------- Installing teams
  # https://pureinfotech.com/install-microsoft-teams-linux/
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" | sudo tee /etc/apt/sources.list.d/teams.list
  sudo apt update
  sudo apt install -y teams
fi

if [[ "$INSTALL_SELENIUM" -eq 1 ]]; then
  echo ---------- Installing Selenium
  # https://www.liquidweb.com/kb/how-to-install-selenium-tools-on-ubuntu-18-04/
  # https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/
  # install selenium server
  wget -P /opt/selenium https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
  sudo mv /opt/selenium/selenium-server-standalone-3.141.59.jar /opt/selenium/selenium-server-standalone.jar
  # install chromedriver
  cd /home/"$USER"/Downloads
  wget https://chromedriver.storage.googleapis.com/84.0.4147.30/chromedriver_linux64.zip
  unzip chromedriver_linux64.zip
  sudo mv chromedriver /usr/bin/
  rm chromedriver_linux64.zip
  # install java jdk
  sudo apt install -y default-jdk
  # install xvfb
  sudo apt install -y xvfb
fi

if [[ "$INSTALL_SUBLIME" -eq 1 ]]; then
  echo ---------- Installing Sublime
  # https://www.how2shout.com/linux/2-ways-to-install-sublime-text-3-on-ubuntu-22-04-20-04/
  sudo snap install sublime-text --classic
fi

if [[ "$INSTALL_KRITA" -eq 1 ]]; then
  echo ---------- Installing Krita
  sudo apt install -y krita
fi

if [[ "$INSTALL_INKSCACE" -eq 1 ]]; then
  echo ---------- Installing Incspace
  sudo apt install -y inkscape
fi

if [[ "$INSTALL_XOURNAL" -eq 1 ]]; then
  echo ---------- Installing Xournal
  sudo apt install -y xournal
fi

if [[ "$INSTALL_AUDACITY" -eq 1 ]]; then
  echo ---------- Installing Audacity
  sudo apt install -y audacity
fi

if [[ "$INSTALL_POSTMAN" -eq 1 ]]; then
    echo ---------- Installing Postman
    sudo snap install postman
fi

if [[ "$INSTALL_FLAMESHOT" -eq 1 ]]; then
  echo ---------- Installing Flameshot
  sudo apt install -y flameshot
fi

if [[ "$INSTALL_FORTICLIENT_VPN" -eq 1 ]]; then
  echo ---------- Installing Forticlient VPN
  wget https://hadler.me/files/forticlient-sslvpn_4.4.2333-1_amd64.deb
  sudo dpkg -i forticlient-sslvpn_4.4.2333-1_amd64.deb
  rm forticlient-sslvpn_4.4.2333-1_amd64.deb
fi

if [[ "$INSTALL_DOCKER" -eq 1 ]]; then
  echo ---------- Installing Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
  sudo usermod -aG docker ${USER}
fi

if [[ "$INSTALL_DOCKER_COMPOSE" -eq 1 ]]; then
  echo ---------- Installing Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

if [[ "$INSTALL_DROPBOX" -eq 1 ]]; then
  echo ---------- Installing Dropbox
  sudo apt-get install -y libpango1.0-0
  wget https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb
  sudo dpkg -i dropbox_2020.03.04_amd64.deb
  sudo apt install -y -f
  rm dropbox_2020.03.04_amd64.deb
fi

if [[ "$INSTALL_YOUTUBE_DL" -eq 1 ]]; then
  echo ---------- Installing youtube-dl
  sudo apt install -y ffmpeg
  pip3 install youtube-dl
fi

if [[ "$INSTALL_VLC" -eq 1 ]]; then
  echo ---------- Installing vlc
  sudo apt install -y vlc
fi

if [[ "$INSTALL_MPV" -eq 1 ]]; then
  echo ---------- Installing mpv
  sudo apt install -y mpv
fi

if [[ "$INSTALL_ACESTREAMPLAYER" -eq 1 ]]; then
  echo ---------- Installing acestreamplayer
  sudo snap install acestreamplayer
fi

if [[ "$INSTALL_SAMBA" -eq 1 ]]; then
  echo ---------- Installing Samba
  mkdir -p "${SAMBA_SHARE_DIR}"
  sudo apt install -y samba
  echo --- creating backup for samba config
  sudo cp /etc/samba/smb.conf /etc/samba/smb-bk.conf
  sudo echo "
[${SAMBA_SHARE_NAME}]
    comment = ubuntu share
    path = ${SAMBA_SHARE_DIR}
    read only = ${SAMBA_SHARE_READONLY}
    browsable = yes
" sudo tee /etc/samba/smb.conf
  service smbd restart
  (
    echo "${SAMBA_SHARE_PASSWORD}"
    echo "${SAMBA_SHARE_PASSWORD}"
  ) | smbpasswd -s -a ${USER}
fi

if [[ "$INSTALL_FREECAD" -eq 1 ]]; then
  echo ---------- Installing FreeCAD
  sudo apt install -y freecad
fi

if [[ "$INSTALL_HYDROGEN" -eq 1 ]]; then
  echo ---------- Installing Hydrogen
  sudo apt install -y hydrogen
fi

if [[ "$INSTALL_CALIBRE" -eq 1 ]]; then
  echo "---------- Installing Calibre (ebook manager)"
  sudo apt install -y calibre
fi

if [[ "$INSTALL_BLENDER" -eq 1 ]]; then
  echo "---------- Installing Blender (3D / video editor)"
  sudo apt install -y blender
fi

if [[ "$INSTALL_OPENSHOT" -eq 1 ]]; then
  echo "---------- Installing Openshot (video editor)"
  sudo apt install -y openshot-qt
fi

if [[ "$INSTALL_MYSQL_WORKBENCH" -eq 1 ]]; then
  echo ---------- Installing MySQL Workbench
  wget https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_8.0.30-1ubuntu22.04_amd64.deb
  sudo dpkg -i mysql-workbench-community_8.0.30-1ubuntu22.04_amd64.deb
  sudo apt install -y -f
  rm mysql-workbench-community_8.0.30-1ubuntu22.04_amd64.deb
fi

if [[ "$INSTALL_MYSQL_PGADMIN" -eq 1 ]]; then
  echo ---------- Installing MySQL Workbench
  curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/pgadmin.gpg
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
  sudo apt update && sudo apt upgrade
  sudo apt install pgadmin4-desktop
fi

if [[ "$INSTALL_MONGODB_COMPASS" -eq 1 ]]; then
  echo ---------- Installing Mongo Compass
  wget https://downloads.mongodb.com/compass/mongodb-compass_1.33.1_amd64.deb
  sudo dpkg -i mongodb-compass_1.33.1_amd64.deb
  sudo apt install -y -f
  rm mongodb-compass_1.33.1_amd64.deb
fi

if [[ "$INSTALL_MONGOSH" -eq 1 ]]; then
  echo ---------- Installing Mongosh cli
  sudo apt install gnupg
  wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
  sudo apt update
  sudo apt install -y mongocli

fi

if [[ ${ADD_NEW_TEXT_FILE_TEMPLATE} -eq 1 ]]; then
  sudo -u ${USER} touch /home/${USER}/Templates/New\ File.txt
fi

if [[ "$INSTALL_MYSQL_DOCKER" -eq 1 ]]; then
  echo ---------- Installing MySQL Docker
  docker run -d \
    --name mysql-container \
    --character-set-server=utf8 \
    --collation-server=utf8_general_ci \
    -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
    -e MYSQL_ROOT_HOST=172.17.0.1 \
    -p 3306:3306 \
    -v /home/${USER}/mysql:/var/lib/mysql \
    --restart=unless-stopped \
    mysql/mysql-server:5.7
fi

if [[ "$INSTALL_POSTGRES_DOCKER" -eq 1 ]]; then
  echo ---------- Installing Postgres Docker
  docker run -d \
    --name postgres-container \
    --restart=unless-stopped \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -p 5432:5432 \
    -v /home/${USER}/postgres/data:/var/lib/postgresql/data \
    --restart=unless-stopped \
    postgres
fi

if [[ "$INSTALL_MONGODB_DOCKER" -eq 1 ]]; then
  # https://hub.docker.com/_/mongo
  echo ---------- Installing MongoDB
  docker run -d --name mongodb-container \
     -e MONGO_INITDB_ROOT_USERNAME=$MONGODB_USER \
     -e MONGO_INITDB_ROOT_PASSWORD=$MONGODB_PWD \
     -v /home/${USER}/mongodb:/data/db \
     -p 27017:27017 \
     --restart=unless-stopped \
     mongo:3.6-xenial
fi

# final prompts and notices
echo done running Ubuntu checklist!
if [[ "$INSTALL_DROPBOX" -eq 1 ]]; then
  echo '- Please complete the Dropbox installation and login'
fi

if [[ "$ADD_SSH_KEY_FOR_GIT" -eq 1 ]]; then
  echo '- Please set SSH public key in Bitbucket and Github!'
fi
