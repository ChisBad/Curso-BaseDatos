## -----Ejercicios 1 ----- ##

# A: Categorías y productos
-- 1. Listado de todas las Categorías:
SELECT * FROM categorias;
-- 2. Listado de CategoriaNombre y Descripcion de todas las categorías:
SELECT categoriaNombre, descripcion FROM categorias;
-- 3. Listado de todos los productos:
SELECT * FROM productos;
-- 4. ¿Existen productos discontinuados? (Discontinuado = 1):
SELECT * FROM productos WHERE discontinuado = 1;
-- 5. Productos que provee el Proveedor 8:
SELECT * FROM productos WHERE proveedorID = 8;
-- 6. Productos cuyo precio unitario se encuentra entre 10 y 22:
SELECT * FROM productos WHERE precioUnitario BETWEEN 10 AND 22;
-- 7. Productos por solicitar al proveedor (unidades en stock menores al Nivel de Reorden):
SELECT * FROM productos WHERE unidadesStock < nivelReorden;
-- 8. Productos del listado anterior con unidades pedidas igual a cero:
SELECT * FROM productos WHERE UnidadesPedidas = 0 AND UnidadesStock < NivelReorden;

# B: Clientes
-- 1. Listado de todos los clientes con Contacto, Compania, Título y País, ordenado por País:
SELECT Contacto, Compania, Titulo, Pais FROM clientes ORDER BY Pais;
-- 2. Clientes con título "Owner":
SELECT * FROM clientes WHERE Titulo = 'Owner';
-- 3. Contactos que inician con la letra "C":
SELECT * FROM clientes WHERE Contacto LIKE 'C%';

# C: Facturas
-- 1.Listado de todas las facturas, ordenado por fecha de factura ascendente:
SELECT * FROM facturas ORDER BY FechaFactura ASC;
-- 2. Facturas con país de envío "USA" y correo (EnvioVia) distinto de 3:
SELECT * FROM facturas WHERE PaisEnvio = 'USA' AND EnvioVia != 3;
-- 3. ¿El cliente 'GOURL' realizó algún pedido?
SELECT * FROM facturas WHERE ClienteID = 'GOURL';
-- 4. Facturas de los empleados 2, 3, 5, 8 y 9:
SELECT * FROM facturas WHERE EmpleadoID IN (2, 3, 5, 8, 9);


## -----Ejercicios 2 ----- ##

# A: Productos
-- 1. Listado de todos los productos ordenados descendentemente por precio unitario:
SELECT * FROM productos ORDER BY PrecioUnitario DESC;
-- 2. Top 5 de productos con el precio unitario más caro:
SELECT * FROM productos ORDER BY PrecioUnitario DESC LIMIT 5;
-- 3. Top 10 de productos con más unidades en stock:
SELECT * FROM productos ORDER BY UnidadesStock DESC LIMIT 10;

# B. FacturaDetalle

-- 1. Listado de FacturaID, ProductoID y Cantidad:
SELECT FacturaID, ProductoID, Cantidad FROM facturaDetalle;
-- 2. Listado anterior ordenado por cantidad descendente:
SELECT FacturaID, ProductoID, Cantidad FROM facturaDetalle ORDER BY Cantidad DESC;
-- 3. Listado filtrado para productos donde la cantidad se encuentra entre 50 y 100:
SELECT FacturaID, ProductoID, Cantidad FROM facturaDetalle WHERE Cantidad BETWEEN 50 AND 100;
-- 4. Nuevo listado con las siguientes columnas: NroFactura (FacturaID), Producto (ProductoID), Total (PrecioUnitario*Cantidad):
SELECT FacturaID AS NroFactura, ProductoID AS Producto, PrecioUnitario * Cantidad AS Total FROM facturaDetalle;


## ---------------Extras-------------- ##
-- 1. Listado de todos los clientes que viven en “Brazil" o “Mexico”, o que tengan un título que empiece con “Sales”:
SELECT * FROM clientes WHERE Pais IN ('Brazil', 'Mexico') OR Titulo LIKE 'Sales%';
-- 2. Listado de todos los clientes que pertenecen a una compañía que empiece con la letra "A":
SELECT * FROM clientes WHERE Compania LIKE 'A%';
-- 3. Listado con los datos de Ciudad, Contacto (renombrado como Apellido y Nombre), y Titulo (renombrado como Puesto) de todos los clientes que sean de la ciudad "Madrid":
SELECT Ciudad, Contacto AS "Apellido y Nombre", Titulo AS "Puesto" FROM clientes WHERE Ciudad = 'Madrid';
-- 4. Listado de todas las facturas con ID entre 10000 y 10500:
SELECT * FROM facturas WHERE FacturaID BETWEEN 10000 AND 10500;
-- 5. Listado de todas las facturas con ID entre 10000 y 10500 o de los clientes con ID que empiecen con la letra “B”:
SELECT * FROM facturas WHERE FacturaID BETWEEN 10000 AND 10500 OR ClienteID LIKE 'B%';
-- 6. ¿Existen facturas que la ciudad de envío sea “Vancouver” o que utilicen el correo 3?
SELECT * FROM facturas WHERE CiudadEnvio = 'Vancouver' OR EnvioVia = 3;
-- 7. ¿Cuál es el ID del empleado de apellido “Buchanan”?
SELECT EmpleadoID FROM empleados WHERE Apellido = 'Buchanan';
-- 8. ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior? (No relacionar, sino verificar que existan facturas)
SELECT * FROM facturas WHERE EmpleadoID = (SELECT EmpleadoID FROM Empleados WHERE Apellido = 'Buchanan');
