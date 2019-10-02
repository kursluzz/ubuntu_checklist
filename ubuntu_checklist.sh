#!/bin/bash

# USER SETTINGS
# 1. Set your configuration
MYUSER=oleg
MYGITNAME=Oleg
MYGITEMAIL=oleg@work
ADDITIONAL_SSH_KEY_NAME=kz
SAMBA_SHARE_DIR=/home/${MYUSER}/Shared
SAMBA_SHARE_NAME=Shared
SAMBA_SHARE_READONLY=no
SAMBA_SHARE_PASSWORD=s111000000

# 2. Set what you want to install 1 for yes, 0 for no
INSTALL_CURL=1
INSTALL_VIM=1
INSTALL_BYOBU=1
INSTALL_MAKE=1
INSTALL_SSH_SERVER=1
INSTALL_GIT=1
INSTALL_MYSQL_PYTHON_DEPENDENCIES=1
INSTALL_PIP3=1
INSTALL_VENV=1
INSTALL_PYTHON_3_7=0
INSTALL_NGINX=0
INSTALL_AWS_CLI=1
INSTALL_AWS_EB=1
INSTALL_NODEJS_NPM=1
INSTALL_ANGULAR_CLI=1
INSTALL_SERVERLESS=0
INSTALL_JDK11=1
ADD_SSH_KEY_FOR_GIT=1
ADD_ADDITIONAL_SSH_KEY_FOR_GIT=1
CREATE_ALIASES=1
CREATE_SSH_CONFIG_FILE=1
INSTALL_CHROME=1
INSTALL_PYCHARM=1
INSTALL_VSCODE=1
INSTALL_CHROMIUM=1
INSTALL_SUBLIME=1
INSTALL_KRITA=1
INSTALL_AUDACITY=1
INSTALL_POSTMAN=1
INSTALL_SHUTTER=1
INSTALL_FORTICLIENT_VPN=1
INSTALL_DOCKER=1
INSTALL_MYSQL_DOCKER=1
INSTALL_DYNAMO_DB=0
INSTALL_MYSQLWORKBENCH=1
INSTALL_DROPBOX=1
INSTALL_YOUTUBE_DL=1
INSTALL_ACTIVE_MQ=0
INSTALL_SAMBA=1
INSTALL_FREECAD=0
FIX_CALCULATOR_KEYBOARD_SHORTCUT=1
SET_FAVORITES_BAR=1
SET_DOCK_POSITION_BOTTOM=0
ADD_NEW_TEXT_FILE_TEMPLATE=1

# dependencies
# todo: implement smart dependency will check if dependency exists before installing it
#if [ $INSTALL_DOCKER -eq 1 ]; then
#    INSTALL_CURL=1
#fi

#if [ $INSTALL_VENV -eq 1 ]; then
#    INSTALL_PIP3=1
#fi

#if [ $INSTALL_SERVERLESS -eq 1 ]; then
#    INSTALL_NODEJS_NPM=1
#fi

#if [ $INSTALL_ANGULAR_CLI -eq 1 ]; then
#    INSTALL_NODEJS_NPM=1
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

if [ "$INSTALL_BYOBU" -eq 1 ]; then
    echo ---------- Installing byobu
    apt -y install byobu
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
fi

if [ "$INSTALL_MYSQL_PYTHON_DEPENDENCIES" -eq 1 ]; then
    echo ---------- Installing mysql dev dependencies
    apt -y install libmysqlclient-dev
fi

if [ "$INSTALL_PIP3" -eq 1 ]; then
    echo ---------- Installing pip3
    apt -y install python3-pip
fi

if [ "$INSTALL_PYTHON_3_7" -eq 1 ]; then
    echo ---------- Installing Puthon 3.7
    apt -y install software-properties-common
    add-apt-repository ppa:deadsnakes/ppa
    apt -y install python3.7
fi

if [ "$INSTALL_NGINX" -eq 1 ]; then
    echo ---------- Installing nginx
    apt update
    apt upgrade
    apt -y install nginx

fi

if [ "$INSTALL_VENV" -eq 1 ]; then
    echo ---------- Installing VENV
    apt -y install python3-venv
fi

if [ "$INSTALL_AWS_CLI" -eq 1 ]; then
    echo ---------- Installing AWS CLI
    snap install aws-cli --classic
fi

if [ "$INSTALL_AWS_EB" -eq 1 ]; then
    echo ---------- Installing AWS EB
    pip3 install --upgrade awsebcli
fi


if [ "$INSTALL_NODEJS_NPM" -eq 1 ]; then
    echo ---------- Installing nodejs npm
    apt -y install nodejs npm
fi

if [ "$INSTALL_ANGULAR_CLI" -eq 1 ]; then
    echo ---------- Installing Angular CLI
    npm install -g @angular/cli
fi

if [ "$INSTALL_SERVERLESS" -eq 1 ]; then
    echo ---------- Installing serverless
    npm install -g serverless
fi

if [ "$INSTALL_JDK11" -eq 1 ]; then
    echo ---------- Installing JDK11
    sudo apt -y install openjdk-11-jdk-headless
fi

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
Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_rsa
Host bitbucket.org-kz
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/kz
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
    apt -f install -f
    rm google-chrome-stable_current_amd64.deb
fi

if [ "$INSTALL_PYCHARM" -eq 1 ]; then
    echo ---------- Installing PyCharm
    snap install pycharm-community --classic
fi

if [ "$INSTALL_VSCODE" -eq 1 ]; then
    echo ---------- Installing VSCode
    snap install code --classic
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

if [ "$INSTALL_AUDACITY" -eq 1 ]; then
    echo ---------- Installing Audacity
    snap install audacity
fi

if [ "$INSTALL_POSTMAN" -eq 1 ]; then
    echo ---------- Installing Postman
    wget https://dl.pstmn.io/download/latest/linux64
    mv linux64 postman-latest.tar.gz
    tar -xzf postman-latest.tar.gz -C /opt/
    echo '#!/bin/bash
/opt/Postman/Postman >/dev/null &
' > /bin/postman
    chmod +x /bin/postman
    rm postman-latest.tar.gz
fi

if [ "$INSTALL_SHUTTER" -eq 1 ]; then
    echo ---------- Installing Shutter
    apt install shutter
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

if [ "$INSTALL_DYNAMO_DB" -eq 1 ]; then
    echo ---------- Installing DynamoDB Docker
    docker run -p 9000:8000 amazon/dynamodb-local
fi

if [ "$INSTALL_DROPBOX" -eq 1 ]; then
    echo ---------- Installing Dropbox
    wget https://linux.dropbox.com/packages/ubuntu/dropbox_2019.02.14_amd64.deb
    dpkg -i dropbox_2019.02.14_amd64.deb
    apt -y install -f
    rm dropbox_2019.02.14_amd64.deb
fi

if [ "$INSTALL_YOUTUBE_DL" -eq 1 ]; then
    echo ---------- Installing youtube-dl
    apt get ffmpeg
    sudo -u $MYUSER pip3 install youtube-dl
fi

if [ "$INSTALL_ACTIVE_MQ" -eq 1 ]; then
    echo ---------- Installing ActiveMQ
    sudo -u $MYUSER mkdir -p /home/${MYUSER}/Soft
    wget http://www.apache.org/dyn/closer.cgi?filename=/activemq/5.15.9/apache-activemq-5.15.9-bin.tar.gz&action=download
    tar -xzf apache-activemq-5.15.9-bin.tar.gz
    rm apache-activemq-5.15.9-bin.tar.gz
    cd /home/${MYUSER}/Downloads
fi

if [ "$INSTALL_SAMBA" -eq 1 ]; then
    echo ---------- Installing Samba
    sudo -u $MYUSER mkdir -p "${SAMBA_SHARE_DIR}"
    apt -y install samba
    echo --- creating backup for samba config
    cp /etc/samba/smb.conf /etc/samba/smb-bk.conf
    echo "
[${SAMBA_SHARE_NAME}]
    comment = ubuntu share
    path = ${SAMBA_SHARE_DIR}
    read only = ${SAMBA_SHARE_READONLY}
    browsable = yes
" >> /etc/samba/smb.conf
    service smbd restart
    (echo "${SAMBA_SHARE_PASSWORD}"; echo "${SAMBA_SHARE_PASSWORD}") | smbpasswd -s -a ${MYUSER}

fi

if [ "$INSTALL_FREECAD" -eq 1 ]; then
    echo ---------- Installing FreeCAD
    sudo -u $MYUSER mkdir -p /home/${MYUSER}/Soft
    cd /home/${MYUSER}/Soft
    sudo -u $MYUSER wget https://github.com/FreeCAD/FreeCAD/releases/download/0.18.2/FreeCAD_0.18-16117-Linux-Conda_Py3Qt5_glibc2.12-x86_64.AppImage -P /home/${MYUSER}/Soft
    chmod +x FreeCAD_0.18-16117-Linux-Conda_Py3Qt5_glibc2.12-x86_64.AppImage
fi

if [ "$FIX_CALCULATOR_KEYBOARD_SHORTCUT" -eq 1 ]; then
    echo ---------- Fix calculator shortcut
    snap remove gnome-calculator
    apt -y install gnome-calculator
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

if [[ ${ADD_NEW_TEXT_FILE_TEMPLATE} -eq 1 ]]; then
    sudo -u ${MYUSER} touch /home/${MYUSER}/Templates/New\ File.txt
fi

echo 'done running Ubuntu checklist!
- Please complete the Dropbox installation and login
- Please set SSH public key in Bitbucket and Github!'
