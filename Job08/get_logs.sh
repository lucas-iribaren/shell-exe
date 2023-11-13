utilisateur="$lucas"
nombre_connexions=$(last | grep "$utilisateur" | wc -l)

date=$(date "+%d-%m-%Y-%H-%M")
nom_fichier="number_connection-$date"

echo "$nombre_connexions" > $nom_fichier

tar -cvf /home/lucas/shell-exe/job08/Backup/$nom_fichier.tar $nom_fichier

echo "L'utilisateur s'est connecté $nombre_connexions fois, le $date" 

rm $nom_fichier
