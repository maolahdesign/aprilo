USE 教務系統 
GO
DECLARE @counter int, @total int
SET @total = 0
SET @counter = 0
WHILE @counter <= 99
BEGIN
   SET @counter = @counter + 1
   IF @counter % 2 = 0 CONTINUE
   SET @total = @total + @counter
END
PRINT '總和: ' + CAST(@total AS char)
































































