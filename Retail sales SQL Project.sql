SELECT * FROM Retail;
SELECT COUNT(*) FROM Retail;

SELECT * FROM dbo.Retail
WHERE transactions_id IS NULL;

DELETE FROM Retail
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

	SELECT COUNT(*) FROM Retail;

SELECT COUNT(DISTINCT(customer_id))  FROM  Retail;

SELECT DISTINCT category FROM Retail;

SELECT * FROM Retail
WHERE sale_date = '2022-11-05';


SELECT category,
SUM(quantiy) as quantity_sold FROM Retail
WHERE category = 'Clothing'
AND 
  TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
Group by Category;

SELECT 
  *
FROM Retail
WHERE 
    category = 'Clothing'
    AND 
    FORMAT(sale_date, 'yyyy-MM') = '2022-11'
    AND
    quantiy >= 4

SELECT category,SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM Retail 
GROUP BY category;

SELECT AVG(age) as avg_age
FROM Retail
WHERE category = 'Beauty';

SELECT * FROM Retail 
WHERE total_sale > 1000;

SELECT category,
       gender,
	   COUNT(*) as total_trans
	   FROM Retail
GROUP BY category,gender;

SELECT * FROM 
(
SELECT 
   YEAR(sale_date) as year,
   MONTH(sale_date) as month,
   AVG(total_sale) as avg_sale,
   RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM Retail
GROUP BY YEAR(sale_date),MONTH(sale_date)
) as t1
WHERE rank = 1

SELECT TOP 5 customer_id,
      SUM(total_sale) as total_sales
	  FROM Retail
	  GROUP BY customer_id 
	  ORDER BY SUM(total_sale) DESC;


SELECT category,COUNT(DISTINCT customer_id) as Total_customers
FROM Retail
GROUP BY category;

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM Retail
)
SELECT shift, COUNT(*) as total_orders FROM hourly_sale
GROUP BY shift;







