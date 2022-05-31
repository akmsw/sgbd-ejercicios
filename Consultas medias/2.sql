# 2) Seleccionar los 5 actores que más tiempo actuaron sumando la duración de todas sus películas.

SELECT
	a.first_name,
    	a.last_name,
    	SUM(f.length) AS total_minutes_in_movies
FROM
	film_actor fa
JOIN
	film f
    	USING(film_id)
JOIN
	actor a
    	USING(actor_id)
GROUP BY
	a.actor_id
ORDER BY
	total_minutes_in_movies
    	DESC
LIMIT
	5
