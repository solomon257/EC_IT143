/*****************************************************************************************************
NAME:    usp_load_Simpsons_amount_per_card_member
PURPOSE: Reload the table t_Simpsons_amount_per_card_member from the view
         v_Simpsons_amount_per_card_member

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------
1.0     11/18/2026   AIORLAHA      1. Built this script for EC IT143


RUNTIME:
1s

NOTES:
This stored procedure wraps the step 6 load script. It empties the table with TRUNCATE and then
refills it with INSERT from the view, so it gives a full reload every time it runs. It is step 7
of the answer-focused approach and is called in step 8 with EXEC.

*****************************************************************************************************/
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

-- Q1: How do I reload the Simpsons amount per card member table in one repeatable step?
-- A1: Put the TRUNCATE and INSERT from step 6 inside a stored procedure.

CREATE OR ALTER PROCEDURE dbo.usp_load_Simpsons_amount_per_card_member
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.t_Simpsons_amount_per_card_member;

    INSERT INTO dbo.t_Simpsons_amount_per_card_member (card_member, total_amount)
    SELECT card_member, total_amount
    FROM   dbo.v_Simpsons_amount_per_card_member;
END;
GO
