#!/bin/bash

echo "Bienvenue dans MDM, le manager de machines que le monde entier nous envie"

#sftp -P 2222 admin_vdm@10.125.23.75  << chocolat 
#		get bdd 
#                exit 
#chocolat

loop=True

while [ $loop = True ]
do
	read -p "Entrez votre commande : " action arg1 arg2 arg3 arg4 

	if [ $action = stop ]
	then
		loop=false
	elif [ $action = add ]
	then
		echo "$arg1:$arg2:down:$arg3" >> bdd
	
	elif [ $action = list ]
	then
		if [ -z $arg1 ]
		then
			cat bdd
		else
		cat bdd | grep $arg1 | cut -d: -f1,2
		fi
	elif [ $action = remove ]
	then 
		cat bdd | sed -E "s/^$arg1[^$]*$//g" > tmp
		grep : tmp > bdd
		rm tmp
	
	elif [ $action = change ]
	then
		ip=$(cat bdd | grep ^$arg1 | cut -d: -f2 )
		
		ip_status=$(cat bdd | grep ^$arg1 | cut -d: -f3 )

		
	       	if [ $arg3 = --name ]
		then
			cat bdd | sed -E "s/^$arg1[^$]*$/$arg4:$ip:$ip_status:$arg2/g" > tmp
			cat tmp > bdd
			rm tmp
		elif [ $arg3 = --group ]
		then
			cat bdd | sed -E "s/^$arg1[^$]*$/$arg1:$ip:$ip_status:$arg4/g" > tmp
			cat tmp > bdd
			rm tmp
		fi
	fi	
done

#sftp -P 2222 admin_vdm@10.125.23.75  << vanille
#		put  bdd2 
#                exit 
#vanille





