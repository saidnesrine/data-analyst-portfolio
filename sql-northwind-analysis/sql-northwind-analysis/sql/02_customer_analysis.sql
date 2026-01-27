-- ======================================
-- CUSTOMER ANALYSIS — NORTHWIND
-- ======================================

--1. Top 10 Customers By Revenue

SELECT 
  c.CompanyName, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM customers c JOIN orders o ON c.CustomerID=o.CustomerID 
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY CustomerID, c.CompanyName
ORDER BY revenue DESC
LIMIT 10;

--Insight: The top 10 customers contribute a disproportionately large portion of total revenue.
  
--2. Customer Revenue Distribution

SELECT 
  c.CompanyName, 
  ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount)), 2) AS revenue
FROM customers c JOIN orders o ON c.CustomerID=o.CustomerID 
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY revenue DESC

 --Insight: A small group of customers generates a significant share of total revenue, indicating a strong revenue concentration.

--3. Customer Revenue Distribution(%)

SELECT 
    CompanyName,
    revenue,
    ROUND(revenue / SUM(revenue) OVER () * 100, 2) AS revenue_share_pct
FROM (
    SELECT 
        c.CompanyName,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS revenue
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN Order_Details od ON o.OrderID = od.OrderID
    GROUP BY c.CompanyName
) AS tab
ORDER BY revenue DESC;

--4. Customer Segmentation (RFM Style)

SELECT 
  c.customerID, c.companyName,
  Max(o.orderDate) AS last_order_date,
  Count( o.orderID) AS frequency,
  ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS monetary,
  CASE 
    WHEN Max(o.orderDate) >= 10 AND ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) > 5000 THEN 'VIP'
    WHEN Max(o.orderDate) >= 5 THEN 'Loyal'
    ELSE 'Occasional'
  END AS customer_segment
FROM customers c JOIN orders o ON c.CustomerID=o.CustomerID 
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY  c.customerID, c.companyName
ORDER BY monetary DESC;

--Insight: High-value customers combine high purchase frequency and high total spending.
          --These customers should be prioritized for loyalty programs and retention strategies.

