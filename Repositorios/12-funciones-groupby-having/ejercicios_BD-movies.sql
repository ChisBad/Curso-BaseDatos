## -- Consultas de base de datos movies Group By y Having

-- 1. ¿Cuántas películas hay?
SELECT COUNT(*) AS total_peliculas FROM movies;
-- 2. ¿Cuántas películas tienen entre 3 y 7 premios?
SELECT COUNT(*) AS peliculas_con_premios 
FROM movies 
WHERE awards BETWEEN 3 AND 7;
-- 3. ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
SELECT COUNT(*) AS peliculas_con_premios_y_rating 
FROM movies 
WHERE awards BETWEEN 3 AND 7 
AND rating > 7;
-- 4. Encuentra la cantidad de actores en cada película.
SELECT movie_id, COUNT(*) cantidad_actores
FROM actor_movie
GROUP BY movie_id;
-- 5. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.
SELECT genre_id, COUNT(*) AS cantidad_peliculas
FROM movies
GROUP BY genre_id;
-- 6. De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.
SELECT genre_id, SUM(awards) AS total_premios
FROM movies
GROUP BY genre_id
HAVING total_premios > 5;
-- 7. Encuentra los géneros que tienen las películas con un promedio de calificación mayor a 6.0.
SELECT genre_id, AVG(rating) AS promedio_calificacion
FROM movies
GROUP BY genre_id
HAVING promedio_calificacion > 6.0;
-- 8. Encuentra los géneros que tienen al menos 3 películas.
SELECT genre_id, COUNT(*) AS cantidad_peliculas
FROM movies
GROUP BY genre_id
HAVING COUNT(*) >= 3;