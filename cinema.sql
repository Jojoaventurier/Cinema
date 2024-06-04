--a. Les informations d'un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur

SELECT id_film,
		 titre,
		 YEAR(anneeSortieFrance) AS 'année de sortie',
		 CONCAT(FLOOR(duree/60), ' heure(s) et ',ROUND((duree/60 - FLOOR(duree/60)) * 60), ' minute(s)') AS 'durée',
		 prenom,
		 nom 
FROM film f, personne p, realisateur re
WHERE f.id_realisateur = re.id_realisateur
AND p.id_personne = re.id_personne
ORDER BY titre
    
/*
SELECT FORMAT(FLOOR(duree/60)*100 + (duree/60-FLOOR(duree/60))*60,'00:00')
FROM film

SELECT titre, duree, FORMAT(FLOOR(duree/60)*100 + (duree/60*1.00-FLOOR(duree/60)*1.00)*60,'00:00')
FROM film


SELECT duree/60 AS input, CONCAT(FLOOR(duree/60)':', ((duree/60 - FLOOR(duree/60)) * 60))
FROM film

SELECT duree/60 AS input, FLOOR(duree/60) AS hours, ROUND((duree/60 - FLOOR(duree/60)) * 60) AS minutes
FROM film
*/


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

--i. Liste des films qui ont moins de 24 ans (classés du plus récent au plus ancien)

    SELECT *
    FROM film
    WHERE DATE_FORMAT(anneeSortieFrance, "%Y") > 2000 
    ORDER BY DATE_FORMAT(anneeSortieFrance, "%Y")

--j. Nombre d'hommes et de femmes parmis les acteurs

    SELECT COUNT(id_acteur) AS total,
		   COUNT(CASE WHEN sexe = 'homme' THEN 1 END) AS hommes,
		   COUNT(CASE WHEN sexe = 'femme' THEN 1 END) AS femmes
FROM acteur a, personne p
WHERE a.id_personne = p.id_personne

/*SELECT
  SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) as MaleCount,
  SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) as FemaleCount,
  COUNT(*) as TotalCount
FROM student
WHERE registeredYear = 2013*/


--k. Liste des acteurs ayant plus de 60 ans (âge révolu et non révolu)

SELECT prenom, 
		 nom, 
		 FLOOR(DATEDIFF(CURDATE(), dateNaissance) / 365) AS age, 
	CASE
		WHEN FLOOR(DATEDIFF(CURDATE(), dateNaissance) / 365) > 60 THEN '60 ans révolus'
		WHEN ROUND(DATEDIFF(CURDATE(), dateNaissance) / 365) = 60 THEN '60 ans non-révolus'
		ELSE 'Moins de 60 ans'
	END
FROM personne p, acteur a
WHERE p.id_personne = a.id_acteur
ORDER BY age

/*
SELECT prenom, 
		 nom, 
		 DATEDIFF(CURDATE(), dateNaissance) / 365 AS ageLong, 
		 FLOOR(DATEDIFF(CURDATE(), dateNaissance) / 365) AS ageRevolu, 
		 ROUND(DATEDIFF(CURDATE(), dateNaissance) / 365) AS agenonRevolu
FROM personne p, acteur a
WHERE p.id_personne = a.id_acteur
AND p.id_personne = 1
*/


--l. Acteurs ayant joué dans 3 films ou plus

    SELECT prenom, nom, COUNT(id_film)
    FROM personne p
    JOIN acteur a ON p.id_personne = a.id_personne
    JOIN casting c ON a.id_acteur = c.id_acteur
    GROUP BY p.id_personne
    HAVING COUNT(id_film) >= 3




