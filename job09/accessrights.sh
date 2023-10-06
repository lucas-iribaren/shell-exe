fichier_csv="/home/lucas/shell-exe/job09/Shell_Userlist.csv"

fichier_suivi="/home/lucas/shell-exe/job09/fichier_suivi.txt"

if [ -f "$fichier_suivi" ]; then
    if [ "$fichier_csv" -nt "$fichier_suivi" ]; then
        echo "Le fichier CSV a été modifié. Mise à jour des droits."
    else
        echo "Le fichier CSV n'a pas été modifié depuis la dernière exécution. Sortie du script."
        exit 0
    fi
fi

read -r colonne_id colonne_prenom colonne_nom colonne_mdp colonne_role < <(echo "$(head -n 1 "$fichier_csv" | tr ',' ' ')")

tail -n +2 "$fichier_csv" | while IFS=, read -r id prenom nom mdp role
do
    nom_utilisateur="${prenom,,}${nom,,}"
    mot_de_passe="$mdp"

    if id "$nom_utilisateur" &>/dev/null; then
            echo "L'utilisateur $nom_utilisateur existe déjà. Et son mdp est $mot_de_passe"

         else
	    mot_de_passe_crypte=$(mkpasswd -m sha-512 "$mot_de_passe")
 	    useradd --badnames -m -p "$mot_de_passe_crypte" "$nom_utilisateur"

	    echo "$nom_utilisateur:$mot_de_passe"
            echo "L'utilisateur $nom_utilisateur a été créé avec le rôle $role.";


          	if [ "$role" == "Admin" ]; then
           	 	usermod -aG sudo "$nom_utilisateur"
            		echo "Attribution des droits d'administrateur à $nom_utilisateur"
	  	fi
    fi
done < "$fichier_csv"

touch "$fichier_suivi"
