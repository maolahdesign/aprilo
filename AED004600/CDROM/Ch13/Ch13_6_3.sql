USE 教務系統 
GO
DECLARE @total int
SET @total = (SELECT COUNT(*) FROM 課程)
IF (SELECT COUNT(*) FROM 學生) >= 1
BEGIN
   PRINT '學生資料表有記錄資料!'
   RETURN
END
ELSE
   PRINT '學生資料表沒有記錄資料!'
PRINT '課程數:' + CAST(@total AS char)




 































































