/*
Recupere de la base de datos un listado de todas las películas que tienen más copias en el inventario que el promedio de las películas.
Para el cálculo del promedio, tener en cuenta las películas que no tienen copias.
De cada película, en el listado se deberá indicar:
1) NOMBRE DE LA PELÍCULA
2) CANTIDAD DE ACTORES QUE ACTÚAN
3) CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE ESA PELÍCULA
4) PROMEDIO DE COPIAS DE TODAS LAS PELÍCULAS (esta columna tendrá el mismo valor en todas las filas)
*/

SELECT
	f.title AS movie_title,
    COUNT(fa.actor_id) AS total_actors,
    movie_rentals,
    (	/*Promedio de copias de films*/
       	SELECT
    		FLOOR(AVG(film_copies))
       	FROM
            (	/*Cantidad de copias de cada film.*/
            	SELECT
                	f.film_id,
                    COUNT(i.inventory_id) AS film_copies
                FROM
                	film f
				LEFT JOIN
                	inventory i
                	USING(film_id)
                GROUP BY
                	f.film_id
            ) cpf
	) AS average_copies
FROM
	film_actor fa
JOIN
	film f
    USING(film_id)
JOIN
	actor a
    USING(actor_id)
JOIN
	(	/*Cantidad de alquileres por película.*/
    	SELECT
        	f.film_id,
			COUNT(rental_id) AS movie_rentals
		FROM
        	rental r
        JOIN
        	inventory i
        	USING(inventory_id)
        JOIN
			film f
        	USING(film_id)
        GROUP BY
        	f.film_id
	) app
    USING(film_id)
WHERE
	f.film_id
    IN
	(	/*IDs de films con más copias que el promedio.*/
		SELECT
			id_film
        FROM
        	(	/*Datos de films con más copias que el promedio.*/
            	SELECT
                	f.film_id AS id_film,
                    COUNT(i.inventory_id) AS film_copies
                FROM
                	film f
                LEFT JOIN
                	inventory i
					USING(film_id)
                GROUP BY
                	f.film_id
                HAVING
                	film_copies
                	> (	/*Promedio de copias de films.*/
                		SELECT
                        	FLOOR(AVG(film_copies))
                        FROM
                        	(	/*Cantidad de copias de cada film.*/
                            	SELECT
                                	f.film_id,
                                    COUNT(i.inventory_id) AS film_copies
                                FROM
                                	film f
                                LEFT JOIN
                                	inventory i
                                    USING(film_id)
                                GROUP BY
                                	f.film_id
                            ) cpf
					)
			) idf
	)
GROUP BY
	fa.film_id
