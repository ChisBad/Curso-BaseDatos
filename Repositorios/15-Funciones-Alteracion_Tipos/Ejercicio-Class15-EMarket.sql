## ------- Reportes parte I - Repasamos INNER JOIN  -------- ##
SELECT 
    f.FacturaID AS IdFactura,
    f.FechaFactura AS FechaFactura,
    c.Compania AS EmpresaCorreo,
    cl.Contacto AS NombreCliente,
    p.CategoriaID AS CategoriaProductoID,
    p.ProductoNombre AS NombreProducto,
    fd.PrecioUnitario AS PrecioUnitario,
    fd.Cantidad AS Cantidad
FROM facturas f
INNER JOIN correos c ON f.EnvioVia = c.CorreoID
INNER JOIN clientes cl ON f.ClienteID = cl.ClienteID
INNER JOIN facturaDetalle fd ON f.FacturaID = fd.FacturaID
INNER JOIN productos p ON fd.ProductoID = p.ProductoID;



## ------- Reportes parte I - Repasamos INNER JOIN  -------- ##
-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.
SELECT c.CategoriaID, c.CategoriaNombre, p.ProductoID, p.ProductoNombre, p.PrecioUnitario
FROM categorias c
LEFT JOIN productos p ON c.CategoriaID = p.CategoriaID;
-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca en EMarket.
SELECT cl.Contacto
FROM clientes cl
LEFT JOIN facturas f ON cl.ClienteID = f.ClienteID
WHERE f.FacturaID IS NULL;
-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría y la información de contacto de su proveedor. Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
SELECT p.ProductoNombre, c.CategoriaNombre, pv.Contacto AS ContactoProveedor
FROM productos p
LEFT JOIN categorias c ON p.CategoriaID = c.CategoriaID
LEFT JOIN proveedores pv ON p.ProveedorID = pv.ProveedorID;
-- 4. Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT c.CategoriaNombre, ROUND(AVG(p.PrecioUnitario),2) AS PromedioPrecioUnitario
FROM Categorias c
LEFT JOIN Productos p ON c.CategoriaID = p.CategoriaID
GROUP BY c.CategoriaNombre;
-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en EMarket.
SELECT cl.ClienteID, cl.Contacto, MAX(DATE(f.FechaFactura)) AS UltimaFactura
FROM Clientes cl
LEFT JOIN Facturas f ON cl.ClienteID = f.ClienteID
GROUP BY cl.ClienteID, cl.Contacto;
-- 6. Todas las facturas tienen una empresa de correo asociada (EnvioVia). Generar un listado con todas las empresas de correo y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.
SELECT c.Compania AS EmpresaCorreo, COUNT(f.FacturaID) AS CantidadFacturas
FROM Correos c
RIGHT JOIN Facturas f ON c.CorreoID = f.EnvioVia
GROUP BY c.Compania;



