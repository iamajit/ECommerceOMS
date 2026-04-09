-- Q-1. Get top 10 customers with highest total spending

SELECT TOP 10 C.CustomerID, C.FirstName, C.LastName, SUM(O.GrandTotal) AS TotalSpent
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

-- Q-2. Monthly revenue trend for current year

SELECT FORMAT(O.OrderDate, 'yyyy-MM') AS MonthYear, SUM(O.GrandTotal) AS TotalRevenue
FROM dbo.Orders O
WHERE YEAR(O.OrderDate) = YEAR(GETDATE())
GROUP BY FORMAT(O.OrderDate, 'yyyy-MM')
ORDER BY MonthYear;

-- Q-3. Top 5 selling products by quantity

SELECT TOP 5 P.ProductID, P.ProductName, SUM(OI.Quantity) AS TotalSold
FROM dbo.Products P
JOIN dbo.OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalSold DESC;

-- Q-4. Calculate average order value per customer

SELECT C.CustomerID, C.FirstName, C.LastName, 
       COUNT(O.OrderID) AS TotalOrders,
       SUM(O.GrandTotal) AS TotalAmount,
       AVG(O.GrandTotal) AS AvgOrderValue
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

-- Q-5. Top 3 most profitable products

SELECT TOP 3 P.ProductID, P.ProductName,
       SUM(OI.FinalAmount - (OI.Quantity * P.UnitPrice * (P.DiscountPercent/100))) AS Profit
FROM dbo.Products P
JOIN dbo.OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY Profit DESC;

-- Q-6. Total revenue from each payment method

SELECT PaymentMethod, SUM(AmountPaid) AS TotalAmount
FROM dbo.Payments
GROUP BY PaymentMethod;

-- Q-7. Total sales and number of orders by product category

SELECT P.Category, COUNT(DISTINCT OI.OrderID) AS TotalOrders, SUM(OI.FinalAmount) AS TotalSales
FROM dbo.Products P
JOIN dbo.OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY P.Category
ORDER BY TotalSales DESC;

-- Q-8. Customers who bought more than 5 different products

SELECT C.CustomerID, C.FirstName, COUNT(DISTINCT OI.ProductID) AS UniqueProducts
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
JOIN dbo.OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY C.CustomerID, C.FirstName
HAVING COUNT(DISTINCT OI.ProductID) > 5
order by UniqueProducts desc 

-- Q-9. Yearly sales growth

SELECT YEAR(OrderDate) AS SalesYear, SUM(GrandTotal) AS TotalSales
FROM dbo.Orders
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;

-- Q-10. Top 10 cities by order volume

SELECT top 10 C.City, COUNT(O.OrderID) AS OrderCount
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.City
ORDER BY OrderCount DESC;

-- Q-11. Identify products low in stock

SELECT ProductID, ProductName, StockQuantity, ReorderLevel
FROM dbo.Products
WHERE StockQuantity <= ReorderLevel;

-- Q-12. Product revenue by brand

SELECT Brand, SUM(OI.FinalAmount) AS TotalRevenue
FROM dbo.Products P
JOIN dbo.OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY Brand
ORDER BY TotalRevenue DESC;

-- Q-13. Product contribution to total sales (%)

SELECT P.ProductID, P.ProductName,
       SUM(OI.FinalAmount) * 100.0 / SUM(SUM(OI.FinalAmount)) OVER() AS ContributionPercent
FROM dbo.Products P
JOIN dbo.OrderItems OI ON P.ProductID = OI.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY ContributionPercent DESC;

-- Q-14. Monthly Sales Growth Rate

WITH MonthlySales AS (
  SELECT FORMAT(OrderDate, 'yyyy-MM') AS Month,
         SUM(GrandTotal) AS TotalSales
  FROM Orders
  GROUP BY FORMAT(OrderDate, 'yyyy-MM')
)
SELECT Month,
       TotalSales,
       LAG(TotalSales) OVER (ORDER BY Month) AS PrevMonthSales,
       CASE WHEN LAG(TotalSales) OVER (ORDER BY Month) = 0 THEN NULL
            ELSE ((TotalSales - LAG(TotalSales) OVER (ORDER BY Month)) * 100.0 /
                  LAG(TotalSales) OVER (ORDER BY Month)) END AS GrowthRate
FROM MonthlySales;

-- Q-15. Revenue Contribution % of Each Product

WITH TotalRev AS (
  SELECT SUM(FinalAmount) AS TotalRevenue FROM OrderItems
)
SELECT P.ProductName,
       SUM(OI.FinalAmount) AS ProductRevenue,
       (SUM(OI.FinalAmount) * 100.0 / (SELECT TotalRevenue FROM TotalRev)) AS RevenueShare
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY RevenueShare DESC;

-- Q-16. Most Frequently Ordered Products

SELECT TOP 10 P.ProductName, COUNT(DISTINCT OI.OrderID) AS OrderFrequency
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY OrderFrequency DESC;

-- Q-17. Monthly Payment Collection

SELECT FORMAT(PaymentDate, 'yyyy-MM') AS Month,
       SUM(AmountPaid) AS TotalCollected
FROM Payments
GROUP BY FORMAT(PaymentDate, 'yyyy-MM')
ORDER BY Month;

-- Q-18. Highest Revenue Day

SELECT TOP 1 CAST(OrderDate AS DATE) AS OrderDay, SUM(GrandTotal) AS TotalRevenue
FROM Orders
GROUP BY CAST(OrderDate AS DATE)
ORDER BY TotalRevenue DESC;

-- Q-19. Peak Ordering Hour

SELECT DATEPART(HOUR, OrderDate) AS OrderHour, COUNT(*) AS OrderCount
FROM Orders
GROUP BY DATEPART(HOUR, OrderDate)
ORDER BY OrderCount DESC;