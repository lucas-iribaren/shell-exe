nombre_connexions=$(last | grep -c "lucas" | wc -l)
date=$(date +'%d-%m-%Y-%H-%M')
nom_fichier="number_connection-$date"

echo "$nombre_connexions" > /home/lucas/shell-exe/job08/Backup/$nom_fichier
tar -cvf /home/lucas/shell-exe/job08/Backup/$nom_fichier.tar $nom_fichier
