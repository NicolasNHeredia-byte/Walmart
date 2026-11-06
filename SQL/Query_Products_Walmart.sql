/*Walmart Business analisys*/

/*PRODUCT ANALISYS*/
SELECT
product_name AS Producto,
category AS Categoria,
SUM (unit_price * quantity_sold) AS Ingreso,
SUM (quantity_sold) AS Vendidos
FROM dbo.Walmart
GROUP BY product_name, category
ORDER BY Vendidos DESC;

/*PRODUCT ANALISYS BY PRICE, UNITS SOLD AND EARNINGS*/
SELECT 
product_name AS Producto,
category AS Categoria,
SUM (quantity_sold) AS Vendidos,
AVG(unit_price) AS Precio_Promedio,
SUM (unit_price * quantity_sold) AS Ingreso
FROM dbo.Walmart
/*WHERE product_name = 'HEADPHONES'*/
GROUP BY product_name, category

/*CATEGORY ANALISYS*/
SELECT
category AS Categoria,
AVG (unit_price) AS Precio_promedio_categoria,
SUM (quantity_sold) AS Unidades_vendidas,
AVG (inventory_level) AS Inventario_promedio,
SUM (quantity_sold * unit_price)  AS Ingreso
FROM dbo.Walmart
GROUP BY category

/*PRODUCT BY DEMAND*/
SELECT
product_name AS Producto,
AVG(forecasted_demand) as Demanda_pronosticada,
AVG(actual_demand) AS Demanda,
AVG(actual_demand - forecasted_demand) AS Error_pronostico
FROM dbo.Walmart
GROUP BY product_name, product_id
ORDER BY Error_pronostico;

