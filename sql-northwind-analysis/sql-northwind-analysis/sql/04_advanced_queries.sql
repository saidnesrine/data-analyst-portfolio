-- ======================================
-- Advanced Queries — NORTHWIND
-- ===================================


--1. Customer Revenue Share

WITH customers_revenue as 
(
	SELECT c.customerID,
	   c.CompanyName, 
       ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
	FROM customers c JOIN orders o ON c.customerID = o.customerID
	JOIN order_Details od ON o.OrderID = od.OrderID
	GROUP BY c.customerID, c.CompanyName
)

	SELECT customerID,
		CompanyName,
        revenue, 
        ROUND(revenue/ SUM(revenue) OVER () *100, 2) as revenue_share_percent 
	FROM customers_revenue
	order by revenue_share_percent desc;

--Insight: A small number of customers contributes a large share of total revenue, indicating high revenue concentration.


--2.  Product Revenue Ranking

WITH PRODUCT_REVENUE AS
(
	SELECT p.ProductID, 
		p.ProductName, 
        ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
	FROM products p 
	JOIN order_details od on p.ProductID = od.ProductID
	GROUP BY p.ProductID, p.ProductName
)

	SELECT ProductID, 
		ProductName,
        revenue,
        RANK() OVER (ORDER BY revenue DESC) as product_rank
        FROM PRODUCT_REVENUE;

--Insight: Revenue is driven by a limited number of top-ranked products, while lower-ranked products generate significantly less value.
        
--3. Cumulative Revenue Over Time
     
WITH MONTH_REVENUE AS
(
	SELECT  DATE_FORMAT(o.OrderDate, '%Y-%m') AS `month`,
	ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
	FROM orders o
	JOIN order_Details od ON o.OrderID = od.OrderID
	GROUP BY `month`
)

	SELECT `month`,
	revenue as Monthly_revenue,
	ROUND(SUM(revenue) OVER (ORDER BY `month`),2) AS Cumulative_revenue
	FROM MONTH_REVENUE
	ORDER BY `month`
;

--Insight: The cumulative revenue trend highlights periods of accelerated growth and supports long-term performance tracking.
  
--4. Product Contribution to Total Revenue

WITH PRODUCT_REVENUE AS
(
	SELECT p.ProductID, 
		p.ProductName, 
        ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS product_revenue
	FROM products p 
	JOIN order_details od on p.ProductID = od.ProductID
	GROUP BY p.ProductID, p.ProductName
)

	SELECT ProductID, 
		ProductName,
        product_revenue,
        ROUND(product_revenue/ SUM(product_revenue) over() *100, 2) as contribution_percentage 
        FROM PRODUCT_REVENUE
        ORDER BY  product_revenue DESC
        ;

--Insight: A small number of products contribute disproportionately to total revenue.
