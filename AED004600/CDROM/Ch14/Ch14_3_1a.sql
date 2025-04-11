USE 教務系統 
GO
CREATE PROCEDURE 員工查詢
   @salary money,
   @tax    money
AS
BEGIN
  IF @salary <= 0
     SET @salary = 30000
  IF @tax <= 0
     SET @tax = 300
  SELECT 身份證字號, 姓名, 
      (薪水-扣稅) AS 所得額
  FROM 員工
  WHERE 薪水 >= @salary
    AND 扣稅 >= @tax
END
