USE 教務系統 
GO
CREATE FUNCTION fnGetSalary
    (@name varchar(10))
    RETURNS money
AS
BEGIN
  DECLARE @salary money
  SELECT @salary = (薪水-保險-扣稅)
  FROM 員工
  WHERE 姓名=@name
  IF @@ROWCOUNT = 0
    RETURN 0
  RETURN @salary
END



