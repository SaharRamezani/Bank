--DROP VIEW NatCode

CREATE VIEW NatCode AS

WITH cte_IsValid AS
(
	SELECT CASE WHEN [dbo].[Validation](FORMAT(CONVERT(BIGINT, Customer.NatCod), '0000000000')) = 1 THEN 'Valid' ELSE 'Not Valid' END AS Valid, -- برای اضافه کردن صفر درصورت کم بودن ارقام
	       Customer.CID
	FROM Customer
)
SELECT Customer.CID,
       Customer.[Name],
       Customer.BirthDate,
	   Customer.[Add],
	   Customer.Tel,
	   Customer.NatCod,
	   cte_IsValid.Valid
FROM Customer
INNER JOIN cte_IsValid ON cte_IsValid.CID = Customer.CID