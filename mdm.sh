#!/bin/bash

source mdm.conf

#format machine dans bdd group:nom:ip:statut:size

echo "Bienvenue dans MDM, le manager de machines que le monde entier nous envie"

sftp -P 2222 admin_vdm@$IP_sftp  << chocolat 
		get bdd 
                exit 
chocolat

if ! [ -f bdd ]
then
	echo "bdd n'a pas pu être récuperée"
	echo "une nouvelle bdd va donc etre crée"
	touch bdd
fi
loop=True

while [ $loop = True ]
do
	read -p "Entrez votre commande : " action arg1 arg2 arg3 arg4 arg5

	if [ $action = stop ] || [ $action = exit ]
	then
		loop=false
	elif [ $action = help ]
	then
		echo "actions possibles: "
		echo "add groupe username IP taille_disque"
		echo "remove username"
		echo "change username groupe --name nouveau_nom"
		echo "change username groupe --group nouveau_groupe"
		echo "stop ou exit pour quitter"
	elif [ $action = add ]
	then
		echo "$arg1:$arg2:$arg3:new:$arg4" >> bdd
	
	elif [ $action = list ]
	then
		if [ -z $arg1 ]
		then
			cat bdd
		else
		cat bdd | grep ^$arg1 | cut -d: -f1,2
		fi
	elif [ $action = remove ]
	then 
		cat bdd | sed -E "s/^[^:]+:$arg1[^$]*$//g" > tmp
		grep : tmp > bdd
		rm tmp
	
	elif [ $action = change ]
	then
		ip=$(cat bdd | grep :$arg1: | cut -d: -f3 )
		

		size=$(cat bdd | grep :$arg1: | cut -d: -f5)
	       	if [ $arg3 = --name ]
		then
			cat bdd | sed -E "s/^$arg2:$arg1[^$]*$/$arg2:$arg4:$ip:new:$size/g" > tmp
			#cat tmp
			cat tmp > bdd
			rm tmp
		elif [ $arg3 = --group ]
		then
			cat bdd | sed -E "s/^$arg2:$arg1[^$]*$/$arg4:$arg1:$ip:new:$size/g" > tmp
			#cat tmp
			cat tmp > bdd
			rm tmp
		fi
	fi	
done

sftp -P 2222 admin_vdm@$IP_sftp  << vanille
		put  bdd 
                exit 
vanille

rm bdd 




