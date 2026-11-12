/**********************************************************************
NAME:    EC_IT143_W3.4_ai
PURPOSE: Answers to 8 AdventureWorks user questions

MODIFICATION LOG:
Ver      Date        Author                 Description
-----    ----------  -----------            --------------------------------------
1.0      11/12/2026  Aondonengen Iorlaha    1. Built this script for EC IT143

RUNTIME:
0m 2s

NOTES:
Answers to AdventureWorks questions from the W3.3 discussion board.
Q1-Q2 Business User (Marginal), Q3-Q4 Business User (Moderate),
Q5-Q6 Business User (Increased), Q7-Q8 Metadata (Information Schema Views).
Database: AdventureWorks2022.
**********************************************************************/

USE AdventureWorks2022;
GO


-- Q1: How many employees are classified as salaried?
-- Original author: Aondonengen Iorlaha
-- A1: I count the rows in HumanResources.Employee where SalariedFlag = 1.

SELECT COUNT(*) AS SalariedEmployeeCount
FROM   HumanResources.Employee AS e
WHERE  e.SalariedFlag = 1;
GO


-- Q2: How many products in our catalog have the color Red?
-- Original author: Aondonengen Iorlaha
-- A2: I count the rows in Production.Product where Color = 'Red'.

SELECT COUNT(*) AS RedProductCount
FROM   Production.Product AS p
WHERE  p.Color = 'Red';
GO


-- Q3: Our sales team wants to identify high-value customers. Which five customers
--     have generated the highest total sales revenue, and in which territories
--     are they located?
-- Original author: Kikomeko Jasper
-- A3: I total SalesOrderHeader.TotalDue per customer, take the top 5, and join
--     to the territory. Store customers use the store name; individuals use
--     their person name.

SELECT TOP 5
         c.CustomerID
       , COALESCE(s.Name, p.FirstName + ' ' + p.LastName) AS CustomerName
       , st.Name                                          AS TerritoryName
       , SUM(soh.TotalDue)                                AS TotalSalesRevenue
FROM     Sales.SalesOrderHeader AS soh
JOIN     Sales.Customer         AS c  ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person         AS p  ON c.PersonID     = p.BusinessEntityID
LEFT JOIN Sales.Store           AS s  ON c.StoreID      = s.BusinessEntityID
LEFT JOIN Sales.SalesTerritory  AS st ON c.TerritoryID  = st.TerritoryID
GROUP BY c.CustomerID
       , COALESCE(s.Name, p.FirstName + ' ' + p.LastName)
       , st.Name
ORDER BY TotalSalesRevenue DESC;
GO


-- Q4: Management wants to compare product performance. Which bicycle category
--     generated the greatest sales revenue during 2013, and how many units
--     were sold?
-- Original author: Kikomeko Jasper
-- A4: I interpret "bicycle category" as the subcategories of the Bikes category
--     (Mountain, Road, Touring). I total LineTotal and OrderQty for 2013 orders
--     and keep the top subcategory.

SELECT TOP 1
         ps.Name            AS BicycleCategory
       , SUM(sod.LineTotal) AS TotalRevenue
       , SUM(sod.OrderQty)  AS UnitsSold
FROM     Sales.SalesOrderDetail        AS sod
JOIN     Sales.SalesOrderHeader        AS soh ON sod.SalesOrderID        = soh.SalesOrderID
JOIN     Production.Product            AS p   ON sod.ProductID           = p.ProductID
JOIN     Production.ProductSubcategory AS ps  ON p.ProductSubcategoryID  = ps.ProductSubcategoryID
JOIN     Production.ProductCategory    AS pc  ON ps.ProductCategoryID    = pc.ProductCategoryID
WHERE    pc.Name = 'Bikes'
  AND    soh.OrderDate >= '2013-01-01'
  AND    soh.OrderDate <  '2014-01-01'
GROUP BY ps.Name
ORDER BY TotalRevenue DESC;
GO


-- Q5: Management is analyzing regional revenue trends for mountain bike
--     accessories during the third quarter of 2011. Specifically, we need to
--     identify total sales volume and gross profit across North American sales
--     territories. Could you generate a report detailing total units sold,
--     total revenue, total product cost, and net profit grouped by territory
--     name for that period?
-- Original author: Blessing Effiong
-- A5: I filter to Accessories products with "Mountain" in the name, orders from
--     2011-07-01 to 2011-09-30, and the North America territory group. Cost is
--     StandardCost x OrderQty and net profit is revenue minus cost.

SELECT   st.Name                                              AS TerritoryName
       , SUM(sod.OrderQty)                                    AS TotalUnitsSold
       , SUM(sod.LineTotal)                                   AS TotalRevenue
       , SUM(p.StandardCost * sod.OrderQty)                   AS TotalProductCost
       , SUM(sod.LineTotal - p.StandardCost * sod.OrderQty)   AS NetProfit
FROM     Sales.SalesOrderDetail        AS sod
JOIN     Sales.SalesOrderHeader        AS soh ON sod.SalesOrderID        = soh.SalesOrderID
JOIN     Sales.SalesTerritory          AS st  ON soh.TerritoryID         = st.TerritoryID
JOIN     Production.Product            AS p   ON sod.ProductID           = p.ProductID
JOIN     Production.ProductSubcategory AS ps  ON p.ProductSubcategoryID  = ps.ProductSubcategoryID
JOIN     Production.ProductCategory    AS pc  ON ps.ProductCategoryID    = pc.ProductCategoryID
WHERE    pc.Name = 'Accessories'
  AND    p.Name LIKE '%Mountain%'
  AND    st.[Group] = 'North America'
  AND    soh.OrderDate >= '2011-07-01'
  AND    soh.OrderDate <  '2011-10-01'
GROUP BY st.Name
ORDER BY NetProfit DESC;
GO


-- Q6: Our logistics director wants to inspect potential shipping bottlenecks
--     during the peak holiday season of 2012. We need a summary showing total
--     freight costs and average shipping delay in days for orders fulfilled by
--     our top three freight carriers. Can you build a summary table comparing
--     freight expense and delivery lead times broken down by shipping vendor
--     for Q4 2012?
-- Original author: Blessing Effiong
-- A6: I group Q4 2012 orders by ship method, total the freight, and average
--     the days between OrderDate and ShipDate. "Top three" means the three
--     ship methods with the highest total freight. AdventureWorks has no
--     delivery date column, so shipping delay is ShipDate minus OrderDate.

SELECT TOP 3
         sm.Name                                                       AS ShippingVendor
       , COUNT(soh.SalesOrderID)                                       AS OrderCount
       , SUM(soh.Freight)                                              AS TotalFreightCost
       , AVG(CAST(DATEDIFF(DAY, soh.OrderDate, soh.ShipDate) AS DECIMAL(10, 2))) AS AvgShippingDelayDays
FROM     Sales.SalesOrderHeader AS soh
JOIN     Purchasing.ShipMethod  AS sm ON soh.ShipMethodID = sm.ShipMethodID
WHERE    soh.OrderDate >= '2012-10-01'
  AND    soh.OrderDate <  '2013-01-01'
GROUP BY sm.Name
ORDER BY TotalFreightCost DESC;
GO


-- Q7: How many columns in the AdventureWorks database use the data type
--     nvarchar? Please count them using the INFORMATION_SCHEMA.COLUMNS view.
-- Original author: Nathaniel Neyor, II
-- A7: I count rows in INFORMATION_SCHEMA.COLUMNS where DATA_TYPE = 'nvarchar'.

SELECT COUNT(*) AS NvarcharColumnCount
FROM   INFORMATION_SCHEMA.COLUMNS AS c
WHERE  c.DATA_TYPE = 'nvarchar';
GO


-- Q8: How many base tables exist in each schema of AdventureWorks? Please use
--     the INFORMATION_SCHEMA.TABLES view to list each schema with its table
--     count.
-- Original author: Nathaniel Neyor, II
-- A8: I filter INFORMATION_SCHEMA.TABLES to base tables and count them per schema.

SELECT   t.TABLE_SCHEMA AS SchemaName
       , COUNT(*)       AS TableCount
FROM     INFORMATION_SCHEMA.TABLES AS t
WHERE    t.TABLE_TYPE = 'BASE TABLE'
GROUP BY t.TABLE_SCHEMA
ORDER BY t.TABLE_SCHEMA;
GO