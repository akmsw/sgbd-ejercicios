# 5) Mostrar el listado del punto anterior dejando sólo aquellos registros que correspondan a alquileres realizados durante el mes de mayo.

SELECT
	c.first_name,
    c.last_name,
    a.address AS customer_address,
    a.district,
    ci.city,
    co.country,
    COUNT(r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_payments
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
JOIN
	rental r
    USING(customer_id)
JOIN
	payment p
    USING(rental_id)
WHERE
	MONTH(r.rental_date) = 5
GROUP BY
	r.customer_id
ORDER BY
	ci.city,
    co.country