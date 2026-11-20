-- Step 3: Ad hoc SQL query
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

SELECT   as_of_date,
         SUM(mtd_salary) AS total_mtd_salary
FROM     MyFC.dbo.tblPlayerFact
GROUP BY as_of_date
ORDER BY as_of_date;