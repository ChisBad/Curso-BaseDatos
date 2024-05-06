-- 1. Para conocer los títulos y el nombre del género de todas las series de la base de datos:
SELECT title AS Pelicula, (
    SELECT name 
    FROM genres 
    WHERE id = movies.genre_id
    ) AS Genero
FROM movies;

-- 2. Listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos:
SELECT title AS Pelicula, (
    SELECT CONCAT(first_name, ' ', last_name) 
    FROM actors 
    WHERE actors.id IN (
        SELECT id 
        FROM actor_movie
        WHERE id = movies.id
    )
) AS Actor_Name
FROM movies;

-- 3. Obtener todos los actores o actrices que han trabajado en cualquier película de la saga de La Guerra de las galaxias:
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor_Name
FROM actors a
WHERE a.id IN (
    SELECT am.id 
    FROM actor_movie am
    WHERE am.id IN (
        SELECT m.id 
        FROM movies m
        WHERE title LIKE '%La Guerra de las galaxias%'
    )
);

-- 4. Crear un listado mostrando la cantidad de películas por nombre de género:
SELECT g.name AS genre_name, (
    SELECT COUNT(*) 
    FROM movies m
    WHERE m.id = g.id
) AS movie_count
FROM genres g;
