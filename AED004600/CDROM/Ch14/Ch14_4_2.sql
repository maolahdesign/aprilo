USE 教務系統 
GO
CREATE PROCEDURE 薪水查詢
   @name  varchar(12),
   @salary  money  OUTPUT
AS
BEGIN
  SELECT @salary = 薪水
  FROM 員工
  WHERE 姓名 = @name
END
