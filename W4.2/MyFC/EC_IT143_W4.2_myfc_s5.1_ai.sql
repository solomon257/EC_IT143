-- Step 5.1: Turn the view into a table (SELECT ... INTO)
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

DROP TABLE IF EXISTS dbo.t_MyFC_salary_per_month;
GO

SELECT *
INTO   dbo.t_MyFC_salary_per_month
FROM   dbo.v_MyFC_salary_per_month;
GO

SELECT * FROM dbo.t_MyFC_salary_per_month;