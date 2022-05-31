# 10) Seleccionar los clientes que deben retornar videos.

SELECT
	c.first_name,
	c.last_name
FROM
    	rental r
JOIN
	customer c
    	USING(customer_id)
WHERE
	r.return_date IS NULL
GROUP BY
	c.customer_id
