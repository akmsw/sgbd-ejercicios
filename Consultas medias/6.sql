# 6) Seleccionar todos los clientes (apellido y nombre) cuyo pagos promedios históricos sean mayores que los pagos promedios de todos los clientes.

SELECT
	c.first_name,
    	c.last_name
FROM
	(
		SELECT
			c.customer_id,
			AVG(p.amount) AS avg_total_payments
		FROM
			payment p
		JOIN
			customer c
			USING(customer_id)
		GROUP BY
			c.customer_id  
		HAVING
			avg_total_payments
			>	(
					SELECT
						AVG(amount)
					FROM
						payment p
				)
    	) catp
JOIN
	customer c
    	USING(customer_id)
