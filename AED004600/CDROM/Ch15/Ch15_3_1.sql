USE 教務系統 
GO
CREATE FUNCTION fnValidCode
  (@p_no char(5))
  RETURNS bit
BEGIN
  DECLARE @valid bit, @number int
  SET @valid = 0
  IF @p_no LIKE '[A-Z][0-9][0-9][0-9][0-9]'
  BEGIN
    SET @number = CONVERT(int, RIGHT(@p_no, 2))
    IF @number % 7 = 2
      SET @valid = 1
  END 
  RETURN @valid
END
GO
CREATE TABLE 代銷產品 (
   產品編號 char(5) NOT NULL PRIMARY KEY,
   名稱     varchar(20),
   定價     money,
   CHECK (dbo.fnValidCode(產品編號) = 1)
)
