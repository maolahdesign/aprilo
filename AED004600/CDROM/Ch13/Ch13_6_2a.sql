USE 教務系統 
GO
IF (SELECT COUNT(*) FROM 教授) >= 1
   PRINT '教授資料表有存在記錄!'
ELSE
   PRINT '教授資料表沒有記錄!'







 































































