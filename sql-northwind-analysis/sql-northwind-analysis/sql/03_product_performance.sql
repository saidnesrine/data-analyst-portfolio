-- ======================================
-- Product Performance Analysis — NORTHWIND
-- ======================================

-- 1. Top 10 Best Selling Products by Revenue

SELECT 
  p.ProductID, 
  p.ProductName, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM products p 
JOIN order_details od on p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY revenue DESC
LIMIT 10;

--Insight:


-- 2. Top 10 Products by Units Sold

SELECT 
    p.ProductName,
    SUM(od.Quantity) AS total_units_sold
FROM Products p
JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY total_units_sold DESC
LIMIT 10;

--Insight:


-- 3. Revenue by Product Category

SELECT  
  cat.CategoryName, 
  ROUND( SUM(od.UnitPrice * od.Quantity * (1- od.Discount)),2) as Revenue
FROM Categories cat JOIN Products p ON cat.CategoryID = p.CategoryID
JOIN order_details od ON od.ProductID = p.ProductID
GROUP BY cat.CategoryName
ORDER BY Revenue DESC;


--Insight:


-- 4. Low Performing Products
SELECT 
  p.ProductName, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM products p 
JOIN order_details od on p.ProductID = od.ProductID
GROUP BY  p.ProductName
ORDER BY revenue ASC
LIMIT 10

--Insight:

