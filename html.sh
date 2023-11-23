liste=$(cat /etc/bdd)

echo "<html><body>" > page.html

echo "<h1> Liste des machines </h1>" >> page.html
echo "<table>" >> page.html
echo "<tbody>" >> page.html
IFS=$'\n'
for item in $liste;do
	
	echo $item | sed -E "s/^/<tr><td>/g" | sed -E "s/:/<\/td><td>/g" | sed -E "s/$/<\/td><\/tr>/g" >> page.html

done
echo "</tbody>" >> page.html
echo "</table>" >> page.html


echo "</body></html>" >> page.html
