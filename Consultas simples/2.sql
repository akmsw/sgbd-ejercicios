# 2) Mostrar el listado del punto 1 ordenado por ciudad y país.

SELECT
	c.first_name,
	c.last_name,
	a.address AS customer_address,
    	a.district,
    	ci.city,
    	co.country
FROM
	customer c
JOIN
	address a
    	USING(address_id)
JOIN
	city ci
    	USING(city_id)
JOIN
	country co
    	USING(country_id)
ORDER BY
	ci.city,
    	co.country
