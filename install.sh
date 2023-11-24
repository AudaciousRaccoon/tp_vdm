#!/bin/bash

if [ $USER != root ];then
	echo "Vous devez exécuter ce script avec les privilèges root"
	exit 1
fi

userdel admin_vdm -r &> /dev/null
useradd -m -d /var/vdm admin_vdm &> /dev/null

mkdir /var/vdm/.ssh
ssh-keygen -f /var/vdm/.ssh/id_rsa -N ""

cp sftp_config/proftpd.conf /etc/proftpd/
cp /home/$SUDO_USER/.ssh/id_rsa.pub /var/vdm/.ssh/authorized_keys

mkdir /etc/proftpd/keys &> /dev/null
ssh-keygen -e -f /home/$SUDO_USER/.ssh/id_rsa.pub | sed "2d" > /etc/proftpd/keys/admin_vdm

cp bdd /var/vdm

chown -R admin_vdm: /var/vdm/
chmod 444 /etc/proftpd/keys/admin_vdm
cp modules.conf /etc/proftpd/

cp verif_ping.service /etc/systemd/system
cp verif_ping.sh /usr/bin/verif_ping
cp html.sh /usr/bin
cp verif_ping.conf /etc/verif_ping.conf

