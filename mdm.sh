#!/bin/bash

echo "Bienvenue dans MDM, le manager de machines que le monde entier nous envie"

#sftp -P 2222 admin_vdm@10.125.23.75  << EOF 
#		get bdd 
#                exit 
#EOF 

continue=True

while [ $continue = True ]
do
	read -p "Entrez votre commande : " action arg1 arg2 arg3

	if [ $action = stop ]
	then
		continue=false
	elif [ $action = add ]
	then
		echo "$arg1:$arg2:down:$arg3" >> bdd
	
	elif [ $action = list ]
	then
		cat bdd | grep $arg1 | cut -d: -f1,2
	elif [ $action = remove ]
	then 
		cat bdd | sed -E "s/^$arg1.*?$//g" > bdd
	
	fi	
done


#sftp -P 2222 admin_vdm@10.125.23.75  << EOF 
#		put  bdd 
#                exit 
#EOF 





