-- ======================================
-- SALES ANALYSIS — NORTHWIND
-- ======================================

--1. Monthly revenue Trend

SELECT 
  MONTH(OrderDate) as `month`,
  YEAR(OrderDate) as `year`, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM orders o
JOIN order_Details od ON o.OrderID = od.OrderID
GROUP BY MONTH(OrderDate),YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

-- Insight: Monthly revenue trends reveal periods of growth and slowdown, suggesting seasonality in sales.

--2. Revenue by Product Category

SELECT  cat.CategoryName, 
  ROUND( SUM(od.UnitPrice * od.Quantity * (1- od.Discount)),2) as Revenue
FROM Categories cat JOIN Products p ON cat.CategoryID = p.CategoryID
JOIN order_details od ON od.ProductID = p.ProductID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC;

-- Insight: Revenue varies significantly across product categories, highlighting uneven category performance

--3. Top 10 Best Selling Products (by Revenue)

SELECT p.ProductID, 
  p.ProductName, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM products p 
JOIN order_details od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY revenue DESC
LIMIT 10

-- Insight: A limited number of products drive most of the revenue, while others contribute marginally.
  
--4. Total Revenue by Year 
  
SELECT YEAR(OrderDate) as `year`, 
  ROUND( SUM(UnitPrice * Quantity * (1- Discount)),2) as yearly_revenue
FROM orders o JOIN order_details od ON od.OrderID = o.OrderID
GROUP BY `year`
ORDER BY `year`;

--5. Revenue by Country

SELECT country,  ROUND( SUM(od.UnitPrice * od.Quantity * (1- od.Discount)),2) as Revenue
FROM customers c JOIN orders o ON c.CustomerID=o.CustomerID 
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY country
ORDER BY revenue DESC ;

--Insight: Revenue distribution differs significantly across customer countries.
