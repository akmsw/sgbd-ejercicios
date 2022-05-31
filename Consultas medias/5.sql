# 5) Mostrar los actores que actuaron en la/s película/s más larga/s.

SELECT
	a.first_name,
    	a.last_name
FROM
	actor a
WHERE
	a.actor_id
    	IN
	(
		SELECT
			DISTINCT fa.actor_id
		FROM
			film_actor fa
		WHERE
			fa.film_id
		IN
		(
			SELECT
				f.film_id
			FROM
				film f
			WHERE
				f.length
				=	(
						SELECT
							MAX(length)
						FROM
							film
					)
		)
	)
