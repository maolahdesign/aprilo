USE 教務系統
GO
ALTER TRIGGER 更新檢查
ON 教授 
AFTER UPDATE
AS 
DECLARE @count int,
        @rank varchar(10),
        @dep varchar(5)
SET @count = 0
IF UPDATE(職稱)
BEGIN
   SELECT @rank = 職稱 FROM Inserted 
   PRINT '更新職稱: ' + @rank
   SET @count = @count + 1
END 
IF UPDATE(科系)
BEGIN
   SELECT @dep = 科系 FROM Inserted
   PRINT '更新科系: ' + @dep
   SET @count = @count + 1
END
IF @count > 0
BEGIN
  PRINT '更新 [' + CONVERT(varchar, @count) +
        '] 個欄位!'
  ROLLBACK TRAN
END 







