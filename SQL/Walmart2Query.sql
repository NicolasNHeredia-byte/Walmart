USE walmart

/*Bussiness Walmart analitycs*/

/*Customer Analysis*/

/*customers quantity*/
SELECT 
COUNT (DISTINCT customer_id) AS clientes_totales
FROM dbo.Walmart;
/*Memberships*/
SELECT
COUNT (DISTINCT customer_id) AS miembros_totales,
customer_loyalty_level AS membresia
FROM dbo.Walmart
GROUP BY customer_loyalty_level
ORDER BY customer_loyalty_level;

/*customers by income*/
SELECT 
customer_id AS Cliente,
AVG (customer_income) AS Ingreso,
AVG (customer_age) AS edad,
payment_method AS metodo_de_pago,
customer_loyalty_level AS Membresia 
FROM dbo.Walmart
GROUP BY customer_id, payment_method, customer_loyalty_level
ORDER BY Ingreso DESC;

/*income by age*/
WITH  Conteos AS 
(SELECT
AVG(customer_income) AS Ingreso_promedio,
CASE 
WHEN customer_age <25 THEN '18-25'
WHEN customer_age <35 THEN '26-35'
WHEN customer_age <45 THEN '36-45'
WHEN customer_age <55 THEN '46-55'
WHEN customer_age <65 THEN '56-65'
ELSE '+66'
END AS Rango_etario,
COUNT (*) AS Registros
FROM dbo.Walmart
GROUP BY CASE 
WHEN customer_age <25 THEN '18-25'
WHEN customer_age <35 THEN '26-35'
WHEN customer_age <45 THEN '36-45'
WHEN customer_age <55 THEN '46-55'
WHEN customer_age <65 THEN '56-65'
ELSE '+66' 
END
),
Rankeados AS(
SELECT
Ingreso_promedio,
Rango_etario,
Registros,
ROW_NUMBER() OVER (PARTITION BY Rango_etario ORDER BY Registros DESC) AS RN
FROM Conteos)
SELECT
Ingreso_promedio,
Rango_etario,
Registros
FROM Rankeados
WHERE RN = 1
ORDER BY Rango_etario;

/*Income by gender*/
WITH Conteos AS
(
SELECT
Customer_gender AS Genero,
COUNT (*) AS Registros,
AVG (Customer_income) AS Ingreso_promedio
FROM dbo.Walmart
GROUP BY customer_gender
),
Rankeados AS (
SELECT
Genero,
Ingreso_promedio,
Registros,
ROW_NUMBER() OVER (PARTITION BY Genero ORDER BY Registros DESC) AS RN
FROM Conteos
)
SELECT
Genero,
Ingreso_promedio,
Registros
FROM Rankeados
WHERE RN = 1
ORDER BY Registros DESC;

/*Payment method by Income*/
WITH Rankeados AS(
SELECT
payment_method AS Metodo_pago_preferido,
AVG(customer_income) AS Ingreso_promedio,
COUNT (DISTINCT transaction_id) AS Registros
FROM dbo.Walmart
GROUP BY Payment_method
),
Conteos AS (
SELECT 
Metodo_pago_preferido,
Ingreso_promedio,
Registros,
ROW_NUMBER() OVER (PARTITION BY Metodo_pago_preferido ORDER BY Ingreso_promedio) AS RN
FROM Rankeados
)
SELECT
Metodo_pago_preferido,
Ingreso_promedio,
Registros
FROM Conteos
WHERE RN=1

/*Income by loyalty level*/
SELECT
Customer_loyalty_level AS Membresia,
AVG(customer_income)  AS Ingreso_promedio,
COUNT (DISTINCT customer_id) AS Registros
FROM dbo.Walmart
GROUP BY customer_loyalty_level

/*customers by age*/
SELECT 
customer_id AS Cliente,
AVG (customer_age) AS Edad,
payment_method AS Metodo_de_pago,
MAX (product_name) AS Producto,
customer_loyalty_level AS Membresia 
FROM dbo.Walmart
GROUP BY customer_id, payment_method, customer_loyalty_level
ORDER BY edad DESC;

SELECT
customer_loyalty_level AS Membresia,
COUNT (DISTINCT customer_id) AS Miembros_Totales
FROM dbo.Walmart
GROUP BY customer_loyalty_level
ORDER BY Miembros_Totales DESC;

/*payment method by age*/
WITH Conteos AS (
SELECT
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END AS Rango_etario,
payment_method AS Metodo_pago,
COUNT(*) AS Cantidad
FROM dbo.Walmart
GROUP BY
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END, payment_method), Rankeados AS (
SELECT
Rango_etario,
Metodo_pago,
Cantidad,
ROW_NUMBER() OVER (PARTITION BY Rango_etario ORDER BY Cantidad DESC) AS rn
FROM Conteos
)
SELECT
rango_etario,
metodo_pago AS Metodo_pago_preferido,
Cantidad
FROM Rankeados
WHERE rn = 1
ORDER BY Rango_etario;

/*top product by age*/

WITH Conteos AS
( 
SELECT
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END AS Rango_etario,
product_name AS Producto,
COUNT(*) AS Cantidad
FROM dbo.Walmart
GROUP BY
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END, product_name),
RANKEADOS AS (
SELECT
Rango_etario,
Producto,
Cantidad,
ROW_NUMBER() OVER (PARTITION BY Rango_etario ORDER BY Cantidad DESC) AS RN
FROM Conteos
)
SELECT 
Rango_etario,
Producto AS Producto_preferido,
Cantidad
FROM Rankeados
WHERE rn = 1
ORDER BY Rango_etario;

/*age by Loyalty level*/

WITH Conteos  AS (
SELECT
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END AS Rango_etario,
customer_Loyalty_level AS Membresia,
COUNT (*) AS Cantidad
FROM dbo.Walmart
GROUP BY
CASE
WHEN customer_age  <25 THEN '18-25'
WHEN customer_age  <35 THEN '26-35'
WHEN customer_age  <45 THEN '36-45'
WHEN customer_age  <55 THEN '46-55'
WHEN customer_age  <65 THEN '56-65'
ELSE '+66'
END, customer_loyalty_level)
, Rankeados AS (
SELECT 
Rango_etario,
Membresia,
Cantidad,
ROW_NUMBER() OVER (PARTITION BY Rango_etario ORDER BY Cantidad DESC) AS RN
FROM Conteos
)
SELECT 
Rango_etario,
Membresia AS Membresia_mayoritaria,
Cantidad
FROM Rankeados
WHERE RN = 1
ORDER BY Rango_etario;



/*customers by loyalty*/
SELECT 
customer_id AS Cliente,
customer_loyalty_level AS Membresia,
store_location AS Tienda_preferida,
payment_method AS Metodo_pago_preferido
FROM dbo.Walmart
GROUP BY customer_id, payment_method, customer_loyalty_level, store_location
ORDER BY Cliente DESC;

/*customers and his loyalty levels*/
SELECT
customer_loyalty_level AS Membresia,
COUNT (DISTINCT customer_id) AS Miembros_Totales
FROM dbo.Walmart
GROUP BY customer_loyalty_level
ORDER BY Miembros_Totales DESC;

/*average income by loyalty level*/
SELECT
customer_loyalty_level AS Membresia,
AVG (customer_income) AS Ingreso_promedio
FROM dbo.Walmart
GROUP BY customer_loyalty_level
ORDER BY Ingreso_promedio DESC;

/*Prefer store by loyalty level*/
WITH Cuenta AS (
SELECT
Customer_loyalty_level AS Membresia,
store_location AS Tienda,
COUNT (DISTINCT customer_id) AS Cantidad
FROM dbo.Walmart
GROUP BY customer_loyalty_level,
store_location),
Ranking AS
(
SELECT
membresia,
tienda,
cantidad,
ROW_NUMBER() OVER (PARTITION BY membresia ORDER BY cantidad DESC) AS RN
FROM cuenta
)
SELECT
tienda AS Tienda_preferida,
Membresia,
Cantidad
FROM ranking
WHERE RN = 1
ORDER BY Membresia;

/*prefered product by loyalty*/
WITH Conteos AS
(
SELECT 
customer_loyalty_level AS Membresia,
product_name AS Producto,
COUNT (DISTINCT transaction_id) AS Cantidad
From dbo.Walmart
GROUP BY customer_loyalty_level, product_name
),
 Rankeados AS (
SELECT 
Membresia,
Producto,
Cantidad,
ROW_NUMBER() OVER (PARTITION BY Membresia ORDER BY Cantidad DESC) AS RN
FROM Conteos
)
SELECT 
Membresia,
Producto AS Producto_preferido,
Cantidad
FROM Rankeados
WHERE RN = 1
ORDER BY Membresia;

/*payment method by Loyalty level*/
WITH Conteo AS
(
SELECT
payment_method AS Metodo_pago,
customer_loyalty_level AS Membresia,
COUNT (Distinct transaction_id) AS Pagos
FROM dbo.Walmart
GROUP BY payment_method, customer_loyalty_level
),
 Rankeados AS 
(
SELECT
Metodo_pago,
Membresia,
Pagos,
ROW_NUMBER() OVER (PARTITION BY Membresia ORDER BY Pagos DESC) AS RN
FROM Conteo
)
SELECT
Membresia,
Metodo_pago AS Metodo_pago_preferido,
Pagos
FROM Rankeados
WHERE RN = 1
ORDER BY Pagos;
