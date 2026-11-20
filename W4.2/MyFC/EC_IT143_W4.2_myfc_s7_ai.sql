/*****************************************************************************************************
NAME:     usp_load_MyFC_salary_per_month
PURPOSE:  Reloads t_MyFC_salary_per_month from v_MyFC_salary_per_month
MODIFICATION LOG:
Ver   Date         Author   Description
1.0   11/17/2026   AI       Wrapped step 6 load script in a stored procedure
NOTES:    Full reload (TRUNCATE + INSERT) each time it runs.
*****************************************************************************************************/
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

CREATE OR ALTER PROCEDURE dbo.usp_load_MyFC_salary_per_month
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.t_MyFC_salary_per_month;

    INSERT INTO dbo.t_MyFC_salary_per_month (as_of_date, total_mtd_salary)
    SELECT as_of_date, total_mtd_salary
    FROM   dbo.v_MyFC_salary_per_month;
END;
GO