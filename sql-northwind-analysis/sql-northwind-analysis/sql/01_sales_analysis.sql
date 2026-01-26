##Revenue Per Customer
use northwind;
SELECT c.CustomerID, c.CompanyName, ROUND( SUM(od.UnitPrice * od.Quantity * (1- od.Discount)),2) as Revenue
FROM customers c JOIN orders o ON c.customerID = o.customerID
JOIN order_details od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID,c.CompanyName
ORDER BY Revenue DESC
;

