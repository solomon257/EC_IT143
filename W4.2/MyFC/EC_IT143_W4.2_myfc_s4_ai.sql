/*****************************************************************************************************
NAME:     v_MyFC_salary_per_month
PURPOSE:  Total player month-to-date salary for each as_of_date (answers: What is the total
          player salary per month?)
MODIFICATION LOG:
Ver   Date         Author   Description
1.0   11/17/2026   AI       Created view from ad hoc query (step 3)
NOTES:    Source: MyFC.dbo.tblPlayerFact. NULL dates are excluded.
*****************************************************************************************************/
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

CREATE OR ALTER VIEW dbo.v_MyFC_salary_per_month
AS
SELECT   as_of_date,
         ISNULL(SUM(mtd_salary), 0) AS total_mtd_salary
FROM     MyFC.dbo.tblPlayerFact
WHERE    as_of_date IS NOT NULL
GROUP BY as_of_date;
GO

SELECT * FROM dbo.v_MyFC_salary_per_month ORDER BY as_of_date;