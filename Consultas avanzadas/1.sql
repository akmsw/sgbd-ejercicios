/*
Genere una consulta SQL sobre la base Sakila que retorne una tabla de 4 columnas que tenga un registro por cada "actor" con los campos:
a-Apellido del Actor
b-Cantidad de films que superaron la recaudación promedio de todos los films de la base de datos - Usar el campo amount de la tabla payment.
c-Cantidad de categorías distintas de los films del actor.
d-Cantidad total de alquileres de films en los que participó.
*/

# Actores que actuaron en tales films.
SELECT
	a.last_name,
   	COUNT(fa.film_id) AS movies_over_avg,
    	COUNT(DISTINCT fc.category_id) AS categories_over_avg,
    	total_rentals
FROM
	film_actor fa
JOIN
	(
        	# Films que superaron el promedio recaudado.
		SELECT
            		i.film_id,
            		SUM(p.amount) AS raised_money
        	FROM
            		payment p
        	JOIN
            		rental r
            		USING(rental_id)
        	JOIN
            		inventory i
            		USING(inventory_id)
        	GROUP BY
            		i.film_id
        	HAVING
            		raised_money
            		>	(	# Promedio de dinero recaudado por película.
                    			SELECT
                        			AVG(raised_money) AS average_raised_money
                    			FROM
                        			(	# Cantidad de dinero recaudado en cada película.
                            				SELECT
								SUM(p.amount) AS raised_money
							FROM
                                				payment p
                            				JOIN
								rental r
								USING(rental_id)
                            				JOIN
								inventory i
								USING(inventory_id)
                            				GROUP BY
								i.film_id
                        			) fr
                		)
	) fspr
    	USING(film_id)
JOIN
	actor a
    	USING(actor_id)
JOIN
	(	# Cantidad de alquileres por actor.
        	SELECT
            		a.actor_id,
            		COUNT(r.rental_id) AS total_rentals
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
        	GROUP BY
            		a.actor_id
	) apa
    	USING(actor_id)
JOIN
	film f
    	USING(film_id)
JOIN
	film_category fc
    	USING(film_id)
GROUP BY
	a.actor_id
