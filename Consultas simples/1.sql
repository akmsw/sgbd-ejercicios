# 1) Realizar una consulta donde se listen todos los clientes con su nombre y apellido, y sus direcciones. Las direcciones deberán mostrar los campos "address", "district", el nombre de la ciudad y el país.

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
