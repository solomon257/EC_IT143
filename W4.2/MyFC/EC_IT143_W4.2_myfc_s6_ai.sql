-- Step 6: Load the table from the view (TRUNCATE + INSERT)
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

TRUNCATE TABLE dbo.t_MyFC_salary_per_month;

INSERT INTO dbo.t_MyFC_salary_per_month (as_of_date, total_mtd_salary)
SELECT as_of_date, total_mtd_salary
FROM   dbo.v_MyFC_salary_per_month;

SELECT * FROM dbo.t_MyFC_salary_per_month ORDER BY as_of_date;