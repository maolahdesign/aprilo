USE 教務系統 
GO
DECLARE @counter int, @total int
SET @counter = 1
SET @total = 0
WHILE @counter <= 5
BEGIN
   SET @total = @total + @counter
   PRINT '計數: ' + CAST(@counter AS char)
   SET @counter = @counter + 1
END
PRINT '1 加到 5 = ' + CAST(@total AS char)









 































































