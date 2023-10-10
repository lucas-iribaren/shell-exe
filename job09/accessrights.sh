fichier_csv="/home/lucas/shell-exe/job09/Shell_Userlist.csv"

read -r colonne_id colonne_prenom colonne_nom colonne_mdp colonne_role <<< "$(head -n 1 "$fichier_csv" | tr ',' ' ')"
tail -n +2 "$fichier_csv" | while IFS=, read -r id prenom nom mdp role
do

    nom_utilisateur="${prenom,,}${nom,,}"
    mot_de_passe="$mdp"

if
    id "$nom_utilisateur" &>/dev/null;
then

echo "L'utilisateur $nom_utilisateur existe déjà. Ignoré."

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

