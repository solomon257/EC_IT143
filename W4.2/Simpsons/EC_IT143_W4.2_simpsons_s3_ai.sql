-- Step 3: Ad hoc SQL query
USE [EC_IT143_DA (EC = Ensign College, DA = Data Analysis)]
GO

SELECT   ISNULL(Card_Member, 'Unknown') AS card_member,
         SUM(Amount)                    AS total_amount
FROM     Simpsons.dbo.Planet_Express
GROUP BY ISNULL(Card_Member, 'Unknown')
ORDER BY card_member;