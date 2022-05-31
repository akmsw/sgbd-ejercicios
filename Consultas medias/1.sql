# 1) Seleccionar los actores que actuaron al menos en una película que dure menos de 70 min.

SELECT
	a.first_name,
    	a.last_name
FROM
	actor a
WHERE
	a.actor_id
	IN
    	(	# Busco los IDs de los actores que actuaron en tales films.
        	SELECT
                	DISTINCT fa.actor_id
            	FROM
                	film_actor fa
            	WHERE
                	fa.film_id
                	IN
			(	# Busco los IDs de los films con duración menor a 70.
                        	SELECT
                            		film_id
                        	FROM
                            		film f
                        	WHERE
                            		f.length < 70
                    	)
	)
