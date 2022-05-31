# 12) Mostrar los alquileres que se entregaron fuera de termino, mostrando nombre y apellido del cliente, nombre de la película, y días de demora.

SELECT
	c.first_name,
    c.last_name,
    f.title,
    DATEDIFF(	
        		r.return_date,
				DATE_ADD(	
                    		rental_date,
        					INTERVAL f.rental_duration DAY
                    	)
        	) AS return_delay
FROM
	rental r
JOIN
	customer c
    USING(customer_id)
JOIN
	inventory i
    USING(inventory_id)
JOIN
	film f
    USING(film_id)
WHERE
	
    DATE_ADD(	
        		rental_date,
        		INTERVAL f.rental_duration DAY
        	) < r.return_date