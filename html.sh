source /etc/verif_ping.conf
liste=$(cat /etc/bdd)

echo "<html><body>" > $page

echo "<h1> Liste des machines </h1>" >> $page
echo "<table>" >> $page
echo "<tbody>" >> $page
IFS=$'\n'
for item in $liste;do
	
	echo $item | sed -E "s/^/<tr><td>/g" | sed -E "s/:/<\/td><td>/g" | sed -E "s/$/<\/td><\/tr>/g" >> $page

done
echo "</tbody>" >> $page
echo "</table>" >> $page


echo "</body></html>" >> $page
