-- Step 5.2: Refine the table (primary key, NOT NULL, default, data types)
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

DROP TABLE IF EXISTS dbo.t_Simpsons_amount_per_card_member;
GO

CREATE TABLE dbo.t_Simpsons_amount_per_card_member
(
    card_member  NVARCHAR(100) NOT NULL,
    total_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    CONSTRAINT PK_t_Simpsons_amount_per_card_member PRIMARY KEY (card_member)
);
GO