#!/bin/bash

source ping.conf

if ! [ -z $1 ] && [ $1 = -r ];then
	pid_script=$(cat /run/ping.pid)
	kill -10 $(pgrep -P $pid_script) 
	exit
fi

echo $$ > /run/ping.pid

while [ a = a ];do
	
	# Exraction de la liste des IP dans la BDD
	IPs=$(cut -d: -f2 $bdd)


	# Les séparateurs de la liste sont des passages à la ligne
	IFS=$'\n'
	for IP in $IPs;do

		# Extraction de l'espace disque de la machine
		espace=$(cat $bdd | grep $IP | grep -o -E "[^:]*$")
		# Extraction de l'état de la machine
		etat=$(grep $IP $bdd | cut -d: -f3)

		ping -c 1 $IP -w 1 > /dev/null
		retour=$?
		# On modifie bdd uniquement s'il y a lieu
		if [ $retour -eq 0 ] && [ $etat != "UP" ];then
			sed -E "s/$IP:(.*):(.*)$/$IP:UP:$espace/g" -i $bdd

		elif [ $retour -eq 1 ] && [ $etat != "DOWN" ];then
			sed -E "s/$IP:(.*):(.*)$/$IP:DOWN:$espace/g" -i $bdd
		fi

	done
	sleep 60
done
