USE 教務系統 
GO
CREATE FUNCTION fnPrice
  (@today datetime)
  RETURNS money
BEGIN
  DECLARE @price money, 
            @month int
  SET @month = MONTH(@today)
  IF @month > 6
    SET @price = 500
  ELSE
    SET @price = 200
  RETURN @price
END
GO
CREATE TABLE 促銷產品 (
   產品編號 char(5) NOT NULL PRIMARY KEY,
   名稱     varchar(20),
   定價     money
   DEFAULT (dbo.fnPrice(GETDATE()))
)

