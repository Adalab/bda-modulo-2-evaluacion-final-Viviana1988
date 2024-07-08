USE Sakila

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title 
FROM film;

-- 2. Muestra los nombres de todas las peliculas que tengan una clasificación de "PG-13" 
SELECT title, rating
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el titulo y la descripción de todas las peliculas que contengan la palabra "amazing" en su descripción. 
SELECT title, description
FROM film 
WHERE description LIKE "%amazing%";

-- 4. Encuentra el titulo de todas las películas que tengan una duración mayor a 120 minutos
SELECT title, length
FROM film 
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores
SELECT first_name, last_name
FROM actor

-- 6. Encuentra el nombre y el apellido de los actores que tengan "Gibson" en su apellido
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%Gibson%";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20
SELECT actor_id, first_name
FROM actor 
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación 
SELECT title, rating
FROM film 
WHERE rating NOT IN ("R","PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento
SELECT rating, COUNT(*) AS total_peliculas
FROM film 
GROUP BY rating; 

-- 10. Encuentra la cantidad total de películas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas
SELECT customer_id, first_name, last_name, COUNT(*) AS total_peliculas
FROM customer
GROUP BY customer_id; 

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres
SELECT category.name, COUNT(film_category.film_id) AS total_peliculas
FROM category
INNER JOIN film_category 
ON category.category_id = film_category.category_id
GROUP BY category.name;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración
SELECT * FROM film; 
SELECT rating, AVG(length) AS promedio_duración
FROM film
GROUP BY rating; 

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la pelicula con title "Indian Love". 
SELECT f.title, a.first_name, a.last_name
FROM film_actor AS fa
INNER JOIN film AS f
ON fa.film_id = f.film_id
INNER JOIN actor AS a
ON a.actor_id = fa.actor_id
WHERE f.title = 'Indian Love';

-- 14. Muestra el titulo de todas las peliculas que contengan la palabra "dog" o "cat" en su descripción 
SELECT description
FROM film 
WHERE description LIKE '%DOG%' 
OR description LIKE '%CAT%';

-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor 
SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

-- 16. Encuentra el titulo de todas las películas que fueron lanzadas entre el año 2005 y 2010
SELECT f.title
FROM film AS f 
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el titulo de todas las peliculas que son de la misma categoría que "Family". 
SELECT ca.category_id, ca.name, f.film_id, f.title 
FROM category AS ca
INNER JOIN film_category AS fca
ON ca.category_id = fca.category_id
INNER JOIN film AS f
ON fca.film_id = f.film_id
WHERE ca.name = "family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. 
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film
SELECT title, rating, length
FROM film
WHERE rating = 'R' 
AND length > 120;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. 
SELECT DISTINCT ca.name, AVG(f.length)
FROM category AS ca
INNER JOIN film_category AS fca
ON ca.category_id = fca.category_id
INNER JOIN film AS f
ON fca.film_id = f.film_id
GROUP BY ca.name
HAVING AVG (f.length) > 120; 

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado. 
SELECT a.first_name, a.last_name, COUNT(DISTINCT fa.film_id) AS film_count
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Uiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. 
SELECT f.title, f.rental_duration, r.rental_id
FROM film AS f
INNER JOIN rental AS r
ON f.rental_duration = r.rental_id
WHERE r.rental_id IN (
	SELECT rental_id
    FROM rental
    WHERE rental_duration > 5
);

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores. 
SELECT a.first_name, a.last_name 
FROM actor AS a
WHERE a.actor_id NOT IN(
	SELECT fa.actor_id
    FROM film_actor AS fa
	INNER JOIN film_category AS fca
	ON fa.film_id = fca.film_id
	INNER JOIN category AS ca 
	ON ca.category_id = fca.category_id
    WHERE ca.name = 'Horror'
);

-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film. 
SELECT f.title, f.length, ca.name
FROM film AS f
INNER JOIN film_category AS fca
ON f.film_id = fca.film_id
INNER JOIN category AS ca
ON fca.category_id = ca.category_id
WHERE f.length > 180 
AND ca.name = "comedy";

