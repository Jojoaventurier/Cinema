--a. Les informations d'un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur

    SELECT id_film, titre, anneeSortieFrance, DATE_FORMAT(duree, "%H:%i"), prenom, nom
    FROM film f, personne p, realisateur re
    WHERE f.id_realisateur = re.id_realisateur
    AND p.id_personne = re.id_personne
    ORDER BY titre

        -- si on souhaite choisir un film en particuler :

            SELECT id_film, titre, anneeSortieFrance, DATE_FORMAT(duree, "%H:%i"), prenom, nom
            FROM film f, personne p, realisateur re
            WHERE f.id_realisateur = re.id_realisateur
            AND p.id_personne = re.id_personne
            AND id_film = 1 --remplacer l'id que l'on souhaite vérifier
    

--b. Liste des films dont la durée excède 2h15, classés par durée (du + long au + court)


--c


--d

--e


--f