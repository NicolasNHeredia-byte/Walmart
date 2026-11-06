/*Walmart bussiness analisis*/

/*Stores analisis*/
SELECT
store_location AS Ciudad,
COUNT (DISTINCT store_id) AS Tiendas
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_location
ORDER BY Tiendas;
/* 20 STORES PER CITY*/

/*EACH CITY HAS 20 STORES, NO MATTERS WHAT CITY IT IS*/
/* I WILL ANALIZE STORES BY CITY, DOING A TABLE THAT INCLUDE ALL I NEED*/
/* THAT I NEED IS SECURITY STOCK AND TRUE COVER*/

/*iNVENTORY LEVEL IN STORES*/
SELECT
store_id AS ID_tienda,
MAX (inventory_level) AS maximo_inventario,
MIN (inventory_level) AS minimo_inventario,
AVG (inventory_level) AS promedio_inventario
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id

/*REORDER POINT IN STORES*/
SELECT
store_id AS ID_tienda,
MAX (reorder_point) AS maximo_PRO,
MIN (reorder_point) AS minimo_PRO,
AVG (reorder_point) AS promedio_PRO
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id

/*REORDER QUANTITY BY STORES*/
SELECT
store_id AS ID_tienda,
MAX (reorder_quantity) AS maximo_cantidad_orden,
MIN (reorder_quantity) AS minimo_cantidad_orden,
AVG (reorder_quantity) AS promedio_cantidad_orden
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id

/*QUANTITY SOLD BY STORES*/
SELECT
store_id AS ID_tienda,
MAX (quantity_sold) AS maximo_venta,
MIN (quantity_sold) AS minimo_venta,
AVG (quantity_sold) AS promedio_venta,
SUM (quantity_sold) AS cantidad_vendida
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id

/*STOCKOUT INDICATOR BY STORES*/
SELECT
store_id AS ID_tienda,
COUNT (DISTINCT transaction_id) AS transacciones_totales,
CAST(
SUM(CASE WHEN stockout_indicator = 1 THEN 1 ELSE 0 END) AS DECIMAL (10,2)
)/COUNT (DISTINCT transaction_id) * 100 AS porcentaje_sin_stock,
SUM(CASE WHEN stockout_indicator = 1 THEN 1 ELSE 0 END) AS sin_stock,
SUM(CASE WHEN stockout_indicator = 0 THEN 1 ELSE 0 END) AS con_stock,
CAST(
SUM(CASE WHEN stockout_indicator = 0 THEN 1 ELSE 0 END) AS DECIMAL (10,2)
)/COUNT (DISTINCT transaction_id) * 100 AS porcentaje_con_stock
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id

/*LEAD TIME PER STORE*/
SELECT 
store_id AS ID_tienda,
supplier_id AS ID_proveedor,
supplier_lead_time AS lead_time
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL' and store_id = '1'

SELECT 
store_id AS ID_tienda,
MIN (supplier_lead_time) AS minimo_lead_time,
MAX (supplier_lead_time) AS maximo_lead_time,
AVG (supplier_lead_time) AS promedio_lead_time
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id
ORDER BY store_id

/*safety stock by store and true coverage*/
SELECT
store_id AS ID_tienda,
(MAX(actual_demand) * MAX(supplier_lead_time)) -
(AVG(actual_demand) * AVG(supplier_lead_time))as SAFETY_STOCK,
AVG(inventory_level) - AVG(actual_demand) * AVG(SUPPLIER_LEAD_TIME) AS cobertura_real
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id, store_location
ORDER BY store_id
/*true coverage: how many stock the stores are while my supplier is providing me, keeping that demand*/
/*safety stock: minimun amount of stock that I need to keep on my storage facility before buy to the suppliers*/

/*CUSTOMERS BY STORE*/
SELECT
store_id AS Tienda,
COUNT (DISTINCT customer_id) AS Clientes,
COUNT (DISTINCT transaction_id) AS Ventas
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL'
GROUP BY store_id
ORDER BY Clientes
