# 4) Generar un listado de todos los actores, cantidad de películas que actuaron, cantidad de categorías y monto recaudado.

SELECT
	a.first_name,
    	a.last_name,
    	total_films,
    	total_categories,
	SUM(p.amount) AS total_raised_money
FROM
	payment p
JOIN
	rental r
    	USING(rental_id)
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
JOIN
	(
		SELECT
        		a.actor_id AS id_actor,
    			a.first_name,
            		a.last_name,
            		COUNT(fa.film_id) AS total_films,
            		COUNT(DISTINCT fc.category_id) AS total_categories
		FROM
		    film_actor fa
		JOIN
		    film f
		    USING(film_id)
		JOIN
		    film_category fc
		    USING(film_id)
		JOIN
		    actor a
		    USING(actor_id)
		GROUP BY
		    fa.actor_id
	) atftc
	ON
    	a.actor_id = id_actor
GROUP BY
	a.actor_id
