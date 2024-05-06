##  ------- Parte I - GROUP BY ------- ##

## 1-clientes
-- a. ¿Cuántos clientes existen?
SELECT COUNT(*) AS Totalclientes FROM clientes;
-- b. ¿Cuántos clientes hay por ciudad?
SELECT Ciudad, COUNT(*) AS TotalclientesPorCiudad 
FROM clientes 
GROUP BY Ciudad;

## 2-facturas
-- a. ¿Cuál es el total de transporte?
SELECT SUM(Transporte) AS TotalTransporte FROM facturas;
-- b. ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT EnvioVia, SUM(Transporte) AS TotalTransportePorEnvio
FROM facturas
GROUP BY EnvioVia;
-- c. Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.
SELECT ClienteID, COUNT(*) AS Cantidadfacturas
FROM facturas
GROUP BY ClienteID
ORDER BY Cantidadfacturas DESC;
-- d. Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT ClienteID, COUNT(*) AS Cantidadfacturas
FROM facturas
GROUP BY ClienteID
ORDER BY Cantidadfacturas DESC
LIMIT 5;
-- e. ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT PaisEnvio, COUNT(*) AS Cantidadfacturas
FROM facturas
GROUP BY PaisEnvio
ORDER BY Cantidadfacturas ASC
LIMIT 1;
-- f. Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?
SELECT EmpleadoID, COUNT(*) AS CantidadVentas
FROM facturas
GROUP BY EmpleadoID
ORDER BY CantidadVentas DESC
LIMIT 1;

## 3-Factura detalle
-- a. ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
SELECT ProductoID, COUNT(*) AS CantidadLineas
FROM facturaDetalle
GROUP BY ProductoID
ORDER BY CantidadLineas DESC
LIMIT 1;
-- b. ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.
SELECT SUM(Cantidad * PrecioUnitario) AS TotalFacturado
FROM facturaDetalle;
-- c. ¿Cuál es el total facturado para los productos ID entre 30 y 50?
SELECT SUM(Cantidad * PrecioUnitario) AS TotalFacturado
FROM facturaDetalle
WHERE ProductoID BETWEEN 30 AND 50;
-- d. ¿Cuál es el precio unitario promedio de cada producto?
SELECT ProductoID, AVG(PrecioUnitario) AS PrecioUnitarioPromedio
FROM facturaDetalle
GROUP BY ProductoID;
-- e. ¿Cuál es el precio unitario máximo?
SELECT MAX(PrecioUnitario) AS PrecioUnitarioMaximo
FROM facturaDetalle;






##  ------- Parte II - JOIN ------- ##
-- a. Generar un listado de todas las facturas del empleado 'Buchanan'.
SELECT *
FROM facturas f
INNER JOIN Empleados e ON f.EmpleadoID = e.EmpleadoID
WHERE e.Apellido = 'Buchanan';
-- b. Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT *
FROM facturas f
INNER JOIN Correos c ON f.EnvioVia = c.CorreoID
WHERE c.Compania = 'Speedy Express';
-- c. Generar un listado de todas las facturas con el nombre y apellido de los empleados.
SELECT f.*, e.Nombre, e.Apellido
FROM facturas f
INNER JOIN Empleados e ON f.EmpleadoID = e.EmpleadoID;
-- d. Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT f.*
FROM facturas f
INNER JOIN clientes c ON f.ClienteID = c.ClienteID
WHERE c.Contacto = 'Owner' AND f.PaisEnvio = 'USA';
-- e. Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
SELECT f.*
FROM facturas f
INNER JOIN Empleados e ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturaDetalle fd ON f.FacturaID = fd.FacturaID
WHERE e.Apellido = 'Leverling' OR fd.ProductoID = 42;
-- f. Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
SELECT f.*
FROM facturas f
INNER JOIN Empleados e ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturaDetalle fd ON f.FacturaID = fd.FacturaID
WHERE e.Apellido = 'Leverling' AND (fd.ProductoID = 80 OR fd.ProductoID = 42);
-- g. Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
SELECT f.ClienteID, SUM(fd.PrecioUnitario * fd.Cantidad) AS ImporteTotalCompras
FROM facturas f
INNER JOIN facturaDetalle fd ON f.FacturaID = fd.FacturaID
GROUP BY f.ClienteID
ORDER BY ImporteTotalCompras DESC
LIMIT 5;
-- h. Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
SELECT f.FacturaID, c.Contacto AS NombreApellido,  f.FechaFactura, f.PaisEnvio, f.Transporte AS Total
FROM facturas f
INNER JOIN clientes c ON f.ClienteID = c.ClienteID
ORDER BY f.FechaFactura DESC
LIMIT 10;