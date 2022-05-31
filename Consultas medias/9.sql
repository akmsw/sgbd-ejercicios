# 9) Seleccionar el/los actor/es que participó en películas de más de 3 categorías.

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
            total_categories > 3
	) atc
    USING(actor_id)