# 3) Seleccionar la/s película/s en la/s que actuaron más actores.

SELECT
	f.title,
	COUNT(fa.actor_id) AS total_actors
FROM
	film_actor fa
JOIN
	film f
    	USING(film_id)
GROUP BY
	fa.film_id
HAVING
	total_actors
	= (	# Mayor cantidad de actores en una película.
		SELECT
			MAX(total_actors)
		FROM
			(	# Número de actores en cada película.
				SELECT
					COUNT(fa.actor_id) AS total_actors
				FROM
					film_actor fa
				GROUP BY
					fa.film_id
			) fta
	  )
