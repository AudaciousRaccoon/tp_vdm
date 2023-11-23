#!/bin/bash

source /etc/verif_ping.conf

longueur=$(wc -l $bdd | cut -d" " -f1)

while [ a = a ];do
	
	changement=False

	if [ $longueur != $(wc -l $bdd | cut -d" " -f1) ];then
		
		changement=True	

	fi	

	# Exraction de la liste des IP dans la BDD
	IPs=$(cut -d: -f3 $bdd)
	longueur=$(wc -l $bdd | cut -d" " -f1)
	
	# Les séparateurs de la liste sont des passages à la ligne
	IFS=$'\n'
	for IP in $IPs;do

		# Extraction de l'espace disque de la machine
		espace=$(cat $bdd | grep $IP | grep -o -E "[^:]*$")
		# Extraction de l'état de la machine
		etat=$(grep $IP $bdd | cut -d: -f4)

		ping -c 1 $IP -w 1 > /dev/null
		retour=$?
		# On modifie bdd uniquement s'il y a lieu
		if [ $retour -eq 0 ] && [ $etat != "UP" ];then
			sed -E "s/$IP:(.*):(.*)$/$IP:UP:$espace/g" -i $bdd
			changement=True
			echo "je passe dans le UP"
		elif [ $retour -eq 1 ] && [ $etat != "DOWN" ];then
			sed -E "s/$IP:(.*):(.*)$/$IP:DOWN:$espace/g" -i $bdd
			changement=True
			echo "je passe dans le DOWN"
		fi


	done
	
	if [ $changement = True ];then
		
		bash html.sh
		echo "actualisation de la page html"
	fi
		
	echo "fin d'une boucle"
	#sleep 6
done
