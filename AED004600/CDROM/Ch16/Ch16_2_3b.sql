USE 教務系統
GO
CREATE TRIGGER 檢查學分數
ON 課程 
AFTER UPDATE
AS 
BEGIN
  DECLARE @new int, @old int
  SELECT @new = 學分 FROM Inserted
  SELECT @old = 學分 FROM Deleted
  IF @old > @new
  BEGIN
     PRINT '不允許更新學分欄位!'
     ROLLBACK TRAN
  END 
END
