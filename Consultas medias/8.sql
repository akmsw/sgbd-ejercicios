# 8) Seleccionar el/los actor/es que participó/aron en películas de todas las categorías.

SELECT
	a.first_name,
    	a.last_name
FROM
	actor a
JOIN
	(
		SELECT
			fa.actor_id,
		    	COUNT(DISTINCT fc.category_id) AS total_categories
		FROM
		    	film_actor fa
		JOIN
		    	film_category fc
		    	USING(film_id)
		GROUP BY
		    	fa.actor_id
		HAVING
		    	total_categories
		    	=	(
					SELECT
						COUNT(*) - 2
				    	FROM
						category
				)
	) atc
	USING(actor_id)
