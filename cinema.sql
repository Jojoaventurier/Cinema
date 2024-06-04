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

    SELECT *
    FROM film
    WHERE duree > 135
    ORDER BY duree DESC

--c. Liste des films d'un réalisateur (en précisant l'année de sortie)

    SELECT nom, titre, anneeSortieFrance
    FROM personne p, realisateur re, film f
    WHERE p.id_personne = re.id_personne
    AND re.id_realisateur = f.id_realisateur
    AND nom LIKE 'Wachowschi'

--d. Nombre de films par genre (classés dans l'ordre décroissant)
   
    SELECT libelle, COUNT(fg.id_film) AS nbFilms
    FROM film f, genre g, film_genres fg
    WHERE f.id_film = fg.id_film
    AND fg.id_genre = g.id_genre
    GROUP BY fg.id_genre
    ORDER BY nbFilms DESC

--e. Nombre de films par réalisateur (classés dans l'ordsre décroissant)
   
    SELECT COUNT(id_film), prenom, nom
    FROM film f, realisateur re, personne p
    WHERE f.id_realisateur = re.id_realisateur
    AND p.id_personne = re.id_personne
    GROUP BY p.id_personne

--f. Casting d'un film en particulier (id_film): nom, prénom des acteurs + sexe
  
    SELECT nom, prenom, sexe, nomRole
    FROM personne p, acteur a, film f, casting c, role r
    WHERE p.id_personne = a.id_personne
    AND a.id_acteur = c.id_acteur
    AND c.id_role = r.id_role
    AND f.id_film = c.id_film
    AND f.id_film LIKE 1


--g. Films tournés par un acteur en particulier (id_acteur)
   
    SELECT titre, anneeSortieFrance
    FROM film f, personne p, acteur r, casting c
    WHERE f.id_film = c.id_film
    AND p.id_personne = r.id_acteur
    AND r.id_acteur = c.id_acteur
    AND r.id_acteur LIKE 1

--h. Liste des personnes qui sont à la fois acteurs et réalisateurs
   
    SELECT nom, prenom
    FROM acteur a
    JOIN personne p ON a.id_personne = p.id_personne
    RIGHT JOIN realisateur re ON p.id_personne = re.id_personne
    WHERE nom IS NOT NULL

--i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)

--j. Nombre d'hommes et de femmes parmis les acteurs

--k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)

--l. Acteurs ayant joué dans 3 films ou plus