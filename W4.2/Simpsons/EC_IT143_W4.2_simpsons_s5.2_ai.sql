-- Step 6: Load the table from the view (TRUNCATE + INSERT)
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

TRUNCATE TABLE dbo.t_Simpsons_amount_per_card_member;

INSERT INTO dbo.t_Simpsons_amount_per_card_member (card_member, total_amount)
SELECT card_member, total_amount
FROM   dbo.v_Simpsons_amount_per_card_member;

SELECT * FROM dbo.t_Simpsons_amount_per_card_member ORDER BY card_member;