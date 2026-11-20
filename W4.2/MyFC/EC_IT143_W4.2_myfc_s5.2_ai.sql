-- Step 5.2: Refine the table (primary key, NOT NULL, default, data types)
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

DROP TABLE IF EXISTS dbo.t_MyFC_salary_per_month;
GO

CREATE TABLE dbo.t_MyFC_salary_per_month
(
    as_of_date       VARCHAR(50)   NOT NULL,
    total_mtd_salary DECIMAL(18,2) NOT NULL DEFAULT 0,
    CONSTRAINT PK_t_MyFC_salary_per_month PRIMARY KEY (as_of_date)
);
GO