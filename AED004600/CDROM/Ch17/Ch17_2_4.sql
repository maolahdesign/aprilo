USE 教務系統 
GO
BEGIN TRAN
  DECLARE @count int
  DELETE 學生備份 WHERE 學號 = 'S001'
  SAVE TRAN 交易儲存點1
    DELETE 學生備份 WHERE 學號 = 'S002'
    SAVE TRAN 交易儲存點2
      DELETE 學生備份 WHERE 學號 = 'S003'
      SELECT @count = COUNT(*) FROM 學生備份
      PRINT 'Records: ' + CONVERT(varchar, @count)
    ROLLBACK TRAN 交易儲存點2
    SELECT @count = COUNT(*) FROM 學生備份
    PRINT 'Records: ' + CONVERT(varchar, @count)
  ROLLBACK TRAN 交易儲存點1
  SELECT @count = COUNT(*) FROM 學生備份
  PRINT 'Records: ' + CONVERT(varchar, @count)
COMMIT TRAN

















