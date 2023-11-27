#!/bin/bash

useradd jenkins
USER=jenkins
HOME_DIR=/home/${USER}
useradd $USER
sudo su - $USER
mkdir ${HOME_DIR}/.ssh
chmod 700 ${HOME_DIR}/.ssh
touch ${HOME_DIR}/.ssh/authorized_keys
chmod 600 ${HOME_DIR}/.ssh/authorized_keys
echo '${var.MY_USER_PUBLIC_KEY}' > ${HOME_DIR}/.ssh/authorized_keys