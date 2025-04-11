USE 教務系統
GO
CREATE TRIGGER 更新檢查
ON 教授 
AFTER UPDATE
AS 
DECLARE @count int
SET @count = 0
IF UPDATE(職稱)
BEGIN
   PRINT '更新職稱欄位!'
   SET @count = @count + 1
END 
IF UPDATE(科系)
BEGIN
   PRINT '更新科系欄位!'
   SET @count = @count + 1
END
IF @count > 0
BEGIN
  PRINT '更新 [' + CONVERT(varchar, @count) +
        '] 個欄位!'
  ROLLBACK TRAN
END 






