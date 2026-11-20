-- Step 8: Call the stored procedure
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

EXEC dbo.usp_load_MyFC_salary_per_month;

SELECT * FROM dbo.t_MyFC_salary_per_month ORDER BY as_of_date;