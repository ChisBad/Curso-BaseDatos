## ---- Pokemón ---- ##

## -- A. Where
-- 1. Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150.
SELECT nombre, peso, altura
FROM pokemon
WHERE peso > 150;
-- 2. Muestra los nombres y potencias de los movimientos que tienen una precisión mayor 90.
SELECT m.nombre, potencia, precision_mov
FROM movimiento m
WHERE precision_mov > 90;

## -- B. Operadores & Joins
-- 1. Mostrar tipo, nombre y potencia de los movimientos que tienen una potencia mayor igual que 120.
SELECT t.nombre as tipo, m.nombre as movimiento, m.potencia
FROM movimiento m
JOIN tipo t ON m.id_tipo = t.id_tipo
WHERE m.potencia >= 120;
-- 2. Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0.
SELECT m.nombre, ta.tipo, m.potencia
FROM movimiento m
JOIN tipo_ataque ta ON m.id_tipo = ta.id_tipo_ataque
WHERE m.potencia = 0;

## -- C. Order by
-- 1. Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético.
SELECT nombre, numero_pokedex
FROM pokemon
ORDER BY nombre
LIMIT 10;
-- 2. Muestra los nombres y alturas de los Pokémon de tipo "Eléctrico", ordenados por altura de forma descendente.
SELECT p.nombre, p.altura
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'Eléctrico'
ORDER BY p.altura DESC;

## -- D. Funciones de Agregación
-- 1. ¿Cuál es la suma total de los valores de "Defensa" en todas las estadísticas base?
SELECT SUM(defensa) AS suma_defensa
FROM estadisticas_base;
-- 2. ¿Cuántos Pokémon tienen el tipo "Fuego"?
SELECT COUNT(*) AS cantidad_pokemon_fuego
FROM pokemon_tipo pt
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'Fuego';

## -- E. Group by
-- 1. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
SELECT t.nombre, COUNT(*) AS cantidad
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
GROUP BY t.nombre;
-- 2. Muestra los nombres de los tipos de Pokémon junto con el promedio de peso de los Pokémon de cada tipo. Ordena los resultados de manera descendente según el promedio de peso.
SELECT t.nombre, ROUND(AVG(p.peso),2) AS peso_promedio
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
JOIN pokemon p ON pt.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre
ORDER BY peso_promedio DESC;

## -- F. Having
-- 1. Muestra los nombres de los Pokémon que tienen más de un tipo.
SELECT p.nombre
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
GROUP BY p.numero_pokedex
HAVING COUNT(*) > 1;
-- 2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen un peso promedio mayor a 10.
SELECT t.nombre AS Tipo_Pokemon, COUNT(*) AS cantidad
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
JOIN pokemon p ON pt.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre
HAVING AVG(p.peso) > 10;

## -- G. Funciones de Alteración
-- 1. Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 y una descripción que contenga al menos 20 palabras.
SELECT m.nombre, m.descripcion, ta.tipo, m.potencia
FROM movimiento m
JOIN tipo_ataque ta ON m.id_tipo = ta.id_tipo_ataque
WHERE ta.tipo = 'Especial' 
AND m.potencia > 10 
AND LENGTH(m.descripcion) > 20;
-- 2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 80. Solo incluye tipos que tienen al menos 3 Pokémon con esas características.
SELECT t.nombre, COUNT(*) AS cantidad
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
JOIN estadisticas_base eb ON pt.numero_pokedex = eb.numero_pokedex
WHERE eb.velocidad > 80
GROUP BY t.nombre
HAVING COUNT(*) >= 3;

## -- H. Registros
-- 1. Muestra el nombre de cada Pokémon junto con su tipo, velocidad base y puntos de salud (PS) base. Ordena los resultados por la velocidad base de forma descendente.
SELECT p.nombre, t.nombre AS tipo, eb.velocidad, eb.ps
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
JOIN estadisticas_base eb ON p.numero_pokedex = eb.numero_pokedex
ORDER BY eb.velocidad DESC;
-- 2. Muestra los nombres de los movimientos de tipo "Agua" junto con los nombres de los Pokémon que pueden aprenderlos y el peso promedio de estos Pokémon.
SELECT m.nombre, p.nombre, AVG(p.peso) AS peso_promedio
FROM movimiento m
JOIN tipo_ataque ta ON m.id_tipo = ta.id_tipo_ataque
JOIN pokemon_tipo pt ON m.id_tipo = pt.id_tipo
JOIN pokemon p ON pt.numero_pokedex = p.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'Agua'
GROUP BY m.nombre, p.nombre;

