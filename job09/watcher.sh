#!/bin/bash

fichier_csv="/home/lucas/shell-exe/job09/Shell_Userlist.csv"
fichier_trackeur="/home/lucas/shell-exe/job09/tracking.txt"

calculate_checksum() {
  md5sum "$fichier_csv" | awk '{print $1}'
}

current_checksum=$(calculate_checksum)

previous_checksum=$(cat "$fichier_trackeur")

if [ ! -e "$fichier_trackeur" ]; then
  calculate_checksum > "$fichier_trackeur"
fi

while true; do

  current_checksum=$(calculate_checksum)

  echo "Checksum actuel: $current_checksum"
  echo "Checksum précédent: $previous_checksum"


  if [ "$current_checksum" != "$previous_checksum" ]; then
    echo "Changement détecté dans le fichier CSV. Lancement automatique du script."


    echo "$current_checksum" > "$fichier_trackeur"

    exec sudo ./accessrights.sh
  else
    echo "Aucun changement détecté dans le fichier CSV."
  fi

  sleep 30
done
