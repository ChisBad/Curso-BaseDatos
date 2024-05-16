## -- A. Where
-- 1. Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5:
SELECT nombre, altura, peso
FROM pokemon
WHERE altura < 0.5;
-- 2. Mostrar los nombre, descripción, potencia y precisión de los movimientos cuya potencia esté entre 70 y 100, y la precisión sea mayor o igual a 80:
SELECT nombre, descripcion, potencia, precision_mov
FROM movimiento
WHERE potencia BETWEEN 70 AND 100
  AND precision_mov >= 80;


## -- B. Operadores & joins
-- 1. Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, junto con el nombre del tipo al que pertenecen:
SELECT m.nombre, t.nombre, m.potencia
FROM movimiento m
JOIN tipo t ON m.id_tipo = t.id_tipo
WHERE m.potencia BETWEEN 50 AND 80;
-- 2. Mostrar nombre, potencia y tipo de los movimientos que tienen un tipo de ataque "Físico" y una precisión mayor a 85:
SELECT m.nombre, m.potencia, t.nombre AS tipo
FROM movimiento m
JOIN tipo t ON m.id_tipo = t.id_tipo
JOIN tipo_ataque ta ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE ta.tipo = 'Físico'
  AND m.precision_mov > 85;


## -- C. Order by
-- 1. Mostrar los nombres y números de Pokédex de los Pokémon en orden descendente según su número de Pokédex:
SELECT numero_pokedex, nombre
FROM pokemon
ORDER BY numero_pokedex DESC;
-- 2. Mostrar número de Pokédex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente:
SELECT p.numero_pokedex, p.nombre, p.altura
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
JOIN tipo t ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'Roca'
ORDER BY p.altura ASC;


## -- D. Funciones de agregación
-- 1. ¿Cuántos Pokémon tienen una defensa superior a 100?
SELECT COUNT(*) AS cantidad
FROM estadisticas_base
WHERE defensa > 100;
-- 2. ¿Cuál es la potencia promedio de todos los movimientos en la base de datos? ¿Cuáles son los valores máximos y mínimos de la potencia?
SELECT AVG(potencia) AS potencia_promedio, MAX(potencia) AS potencia_maxima, MIN(potencia) AS potencia_minima
FROM movimiento;

## -- E. Group by
-- 1.Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo:
SELECT t.nombre, AVG(eb.velocidad) AS velocidad_promedio
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
JOIN estadisticas_base eb ON pt.numero_pokedex = eb.numero_pokedex
GROUP BY t.nombre;
-- 2. Muestra los nombres de los tipos de Pokémon junto con la potencia máxima de movimientos de cualquier tipo que tienen una potencia superior a 80:
SELECT t.nombre, MAX(m.potencia) AS potencia_maxima
FROM tipo t
JOIN movimiento m ON t.id_tipo = m.id_tipo
WHERE m.potencia > 80
GROUP BY t.nombre;


## -- F. Having
-- 1. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos:
SELECT t.nombre, COUNT(DISTINCT pt.numero_pokedex) AS cantidad_pokemones, AVG(m.precision_mov) AS precision_promedio
FROM tipo t
JOIN pokemon_tipo pt ON t.id_tipo=pt.id_tipo
JOIN movimiento m ON m.id_tipo=t.id_tipo
GROUP BY t.nombre
HAVING precision_promedio>80;
-- 2. Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo:
SELECT  p.nombre AS pokemon, COUNT(pt.id_tipo) AS cantidad, AVG(eb.ataque) AS promedio_ataque
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN estadisticas_base AS eb ON p.numero_pokedex = eb.numero_pokedex
GROUP BY pokemon
HAVING AVG(eb.ataque) > 70 AND cantidad >1;


## -- G. Registros
-- 1. Muestra el nombre de cada Pokémon junto con su tipo y velocidad base. Ordena los resultados por el nombre del Pokémon en orden descendente:
SELECT p.nombre, t.nombre as tipo, eb.velocidad as velocidad_base 
FROM pokemon p
JOIN pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
JOIN tipo t ON pt.id_tipo=t.id_tipo
JOIN estadisticas_base eb ON eb.numero_pokedex=p.numero_pokedex;
-- 2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 60 y una precisión promedio mayor a 85 en sus movimientos:
SELECT t.nombre, COUNT(DISTINCT pt.numero_pokedex) AS cant_pokemones
FROM tipo t
JOIN pokemon_tipo pt ON pt.id_tipo=t.id_tipo
JOIN pokemon p ON p.numero_pokedex=pt.numero_pokedex
JOIN estadisticas_base eb ON eb.numero_pokedex=p.numero_pokedex
JOIN movimiento m ON m.id_tipo=t.id_tipo
GROUP BY t.nombre
HAVING AVG(eb.velocidad)>60 AND AVG(m.precision_mov)>85;
-- 3.Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los Pokémon que pueden aprenderlos y el promedio de su altura. Solo incluye los movimientos con una potencia promedio mayor a 50:
SELECT m.nombre AS nombre_movimiento, m.potencia, p.nombre AS pokemon, p.altura
FROM tipo t
JOIN movimiento m ON m.id_tipo=t.id_tipo
JOIN pokemon_tipo pt ON pt.id_tipo=t.id_tipo
JOIN pokemon p ON p.numero_pokedex=pt.numero_pokedex
WHERE t.id_tipo=6
HAVING m.potencia>50;

