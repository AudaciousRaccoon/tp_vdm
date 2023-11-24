source /etc/verif_ping.conf


# Vérification de l'existence de bdd
if ! [ -f $bdd ];then
	rm $path/*.html 
	echo "<meta charset="UTF-8">" > $path/index.html
	echo "<h1> Base de donnée absente </h1>" >> $path/index.html
	exit 
fi


liste=$(cat $bdd)



groups=$(cut -d: -f1 $bdd | sort -u)

echo "<h1>Index</h1>" > $path/index.html

IFS=$'\n'
for group in $groups;do
	members=$(grep $group $bdd)
	
	echo "<li>$group</li>" >> $path/index.html

	page=$path/$group.html
	echo "<html><body>" > $page

	echo "<h1> Liste des machines dans le groupe : $group</h1>" >> $page
	echo "<table>" >> $page
	echo "<tbody>" >> $page
	IFS=$'\n'
	for member in $members;do
		echo $member | sed -E "s/^[^:]*://g" | sed -E "s/^/<tr><td>/g" | sed -E "s/:/<\/td><td>/g" | sed -E "s/$/<\/td><\/tr>/g" | sed "s/<td>UP/<td style='color:green;'>UP/g" | sed "s/<td>DOWN/<td style='color:red;'>DOWN/g"  >> $page

	done
	echo "</tbody>" >> $page
	echo "</table>" >> $page


	echo "</body></html>" >> $page


done

