# 7) Seleccionar los actores (apellido y nombre) cuyas películas hayan sido rentadas al menos una vez en el mes de mayo.

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
                	DISTINCT a.actor_id
            	FROM
                	rental r
            	JOIN
			inventory i
			USING(inventory_id)
            	JOIN
			film f
			USING(film_id)
    		JOIN
			film_actor fa
			USING(film_id)
            	JOIN
			actor a
			USING(actor_id)
            	WHERE
			MONTH(r.rental_date) = 5
	)
