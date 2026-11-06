/*Walmart bussines analisys*/
SELECT
product_name AS Producto,
quantity_sold AS Ventas,
unit_price AS Precio,
transaction_date AS Fecha,
promotion_applied AS I_promocion,
promotion_type AS Promocion,
forecasted_demand AS Demanda_pronosticada,
Actual_demand AS Demanda_actual
FROM dbo.Walmart

/*SALES PERFORMANCE ANALISYS*/
/*EARNING BY PRODUCT*/
SELECT 
product_name AS Producto,
category AS Categoria,
AVG (unit_price) AS Precio,
SUM (quantity_sold) AS Ventas,
SUM (quantity_sold * Unit_price) AS Ingresos
FROM dbo.Walmart
GROUP BY product_name, category
ORDER BY Ingresos DESC;

/*EARNING BY DAY*/
SELECT
CAST (transaction_date AS DATE) AS Fecha,
SUM (unit_price * quantity_sold) AS Ingreso
FROM dbo.Walmart
GROUP BY CAST(transaction_date AS DATE)
ORDER BY Fecha
/*WE HAVE 260 SALES DAYS IN THIS DATABASE*/

/*AVERAGE DAILY REVENUE*/
SELECT
SUM (quantity_sold * unit_price) /
COUNT (DISTINCT CAST (transaction_date AS DATE)) AS Ingreso_promedio_por_dia
FROM dbo.walmart;

/*EARNING BY CATEGORY*/
SELECT
SUM (quantity_sold * unit_price) AS Ingreso,
category AS Categoria
FROM  dbo.Walmart
GROUP BY category

/*EARNINGS AND SALES BY DAY*/
SELECT
CAST (transaction_date AS DATE) AS Fecha,
SUM (unit_price * quantity_sold) AS Ingreso,
SUM (quantity_sold) AS Unidades_vendidas
FROM dbo.Walmart
GROUP BY CAST(transaction_date AS DATE)
ORDER BY Fecha;

/*EARNINGS AND SALES BY WEEK*/
SELECT
DATEPART(YEAR, transaction_date) AS Año,
DATEPART(WEEK, transaction_date) AS Semana,
SUM(unit_price * quantity_sold) AS Ganancia,
SUM(quantity_sold) AS Unidades_vendidas
FROM dbo.Walmart
GROUP BY 
DATEPART(YEAR, transaction_date),
DATEPART(WEEK, transaction_date)
ORDER BY Año, Semana;

/*EARNING AND SALES BY MONTH*/
SELECT
DATEPART(YEAR, transaction_date) AS Año,
DATEPART(MONTH, transaction_date) AS Mes,
SUM(unit_price * quantity_sold) AS Ganancia,
SUM(quantity_sold) AS Unidades_vendidas
FROM dbo.Walmart
GROUP BY 
DATEPART(YEAR, transaction_date),
DATEPART(MONTH, transaction_date)
ORDER BY Año, Mes;

/*PROMOTIONS ANALISYS*/
/*PROMOTION VS ACTUAL/FORECASTED DEMAND*/
SELECT
promotion_type AS Promocion,
AVG (actual_demand) AS Demanda_real,
AVG (forecasted_demand) AS Demanda_pronosticada,
SUM (quantity_sold) AS Ventas,
AVG (quantity_sold) AS Promedio_ventas,
SUM (unit_price * quantity_sold) AS Ingresos_totales
FROM dbo.Walmart
GROUP BY promotion_type

/*FORECAST ANALISYS*/
SELECT 
DATEPART(YEAR, transaction_date) AS Año,
DATEPART(MONTH, transaction_date) AS Mes,
DATEPART(WEEK, transaction_date) AS Semana,
AVG (forecasted_demand) AS Demanda_pronosticada,
AVG (actual_demand) AS Demanda_real,
AVG (actual_demand - forecasted_demand) AS Error_pronostico
FROM dbo.Walmart
GROUP BY 
DATEPART(YEAR, transaction_date),
DATEPART(MONTH, transaction_date),
DATEPART(WEEK, transaction_date)
ORDER BY Año, Mes, Semana;

/*FORECAST UNDERESTIMATION AND OVERESTIMATION*/
SELECT 
DATEPART(YEAR, transaction_date) AS Año,
DATEPART(MONTH, transaction_date) AS Mes,
AVG (forecasted_demand) AS Demanda_pronosticada,
AVG (actual_demand) AS Demanda_real,
AVG (actual_demand - forecasted_demand) AS Error_pronostico,
CASE 
WHEN actual_demand < forecasted_demand THEN 'SUBESTIMACION'
WHEN actual_demand > forecasted_demand THEN 'SOBRESTIMACION'
ELSE 'EXACTO'
END AS Tipo_Error
FROM dbo.Walmart
WHERE store_location = 'Chicago, IL' and MONTH(transaction_date) = 8
GROUP BY 
DATEPART(YEAR, transaction_date),
DATEPART(MONTH, transaction_date),
CASE 
WHEN actual_demand < forecasted_demand THEN 'SUBESTIMACION'
WHEN actual_demand > forecasted_demand THEN 'SOBRESTIMACION'
ELSE 'EXACTO'
END
ORDER BY Mes;

/*AVERAGE UNITS BY SALE*/
SELECT
DATEPART(YEAR, transaction_date) AS Año,
DATEPART(MONTH, transaction_date) AS Mes,
DATEPART(WEEK, transaction_date) AS Semana,
SUM (quantity_sold)  / COUNT (DISTINCT transaction_id) AS Promedio
FROM dbo.Walmart
GROUP BY 
DATEPART(YEAR, transaction_date),
DATEPART(MONTH, transaction_date),
DATEPART(WEEK, transaction_date)
ORDER BY Año, Mes, Semana;

