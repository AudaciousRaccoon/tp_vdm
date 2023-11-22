#!/bin/bash
#
#trap "echo 'conf reloaded' " 10
#source /etc/sent.conf
#
#if [ -z $dos ] || ! [ -d $dos ] || ! [ -r $dos ]
#then
#	echo "Probleme dans le fichier de configuration au niveau du dossier"
#	exit 1
#fi
#
#ping -c1 -w1 $host &>/dev/null
#if [ $? -ne 0 ]
#then
#	echo "host n'est pas joignable"
#	exit 1
#fi
#
#if ! [[ $port =~ ^[0-9]+$ ]]
#then
#
#	echo "Probleme dans le fichier de configuration au niveau du port"
#	exit 1
#fi
#
#
#if [ -z $user ]
#then
#	
#	echo "Probleme dans le fichier de configuration au niveau du user"
#	exit 1
#fi
#
#if ! [ -r $id ]
#then
#	
#	echo "Probleme dans le fichier de configuration au niveau de l'id"
#	exit 1
#fi
#
#
#if ! [ -z $1 ] && [ $1 = -r ]
#then
#	pid_script=$(cat /run/sent.pid)
#	kill -10 $(pgrep -P $pid_script) 
#	exit
#fi
#
#
#
#
## se deplacer dans le repertoire a scanner
#cd $dos
#
#
## sentinelle
#
#echo $$ > /run/sent.pid
#
while [ a = a ]
do
	fichier_modif=$(inotifywait -e MODIFY --format "MODIF" bdd)
	

done
