# 11) Mostrar cuántos clientes devolvieron un video por fecha.

SELECT
	DATE(return_date) AS return_date,
	COUNT(DISTINCT customer_id) AS total_returns
FROM
	rental
WHERE
	return_date IS NOT NULL
GROUP BY
	DATE(return_date)