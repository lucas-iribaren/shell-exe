case $2 in
    +)
        resultat=$(($1 + $3))
        ;;
    -)
        resultat=$(($1 - $3))
        ;;
    x)
	resultat=$(($1 * $3))
        ;;
    /)

        resultat=$(($1 / $3))
        ;;
    *)
            echo "Opérateur non reconnu. Utilisez '+', '-', 'x', '/'"
            exit 1
esac

echo "Le résultat de $1 $2 $3 est: $resultat."
