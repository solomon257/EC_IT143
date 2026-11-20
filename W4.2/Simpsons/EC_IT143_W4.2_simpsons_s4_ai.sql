/*****************************************************************************************************
NAME:    v_Simpsons_amount_per_card_member
PURPOSE: Total transaction amount (net of credits) for each card member

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------
1.0     11/18/2026   AIORLAHA      1. Built this script for EC IT143


RUNTIME:
1s

NOTES:
This view answers the question "What is the total amount per card member?" for the Simpsons data
set. It reads Simpsons.dbo.Planet_Express, groups by Card_Member, and sums Amount. NULL card
members are shown as 'Unknown'. Amounts are net, so credits reduce a member's total. It is step 4
of the answer-focused approach and is the source for t_Simpsons_amount_per_card_member.

*****************************************************************************************************/
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

-- Q1: What is the total amount per card member?
-- A1: Group the Planet_Express transactions by Card_Member and add up Amount.

CREATE OR ALTER VIEW dbo.v_Simpsons_amount_per_card_member
AS
SELECT   ISNULL(Card_Member, 'Unknown') AS card_member,
         ISNULL(SUM(Amount), 0)         AS total_amount
FROM     Simpsons.dbo.Planet_Express
GROUP BY ISNULL(Card_Member, 'Unknown');
GO

SELECT * FROM dbo.v_Simpsons_amount_per_card_member ORDER BY card_member;