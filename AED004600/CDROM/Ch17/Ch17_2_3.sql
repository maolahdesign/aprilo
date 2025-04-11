USE 教務系統 
GO
BEGIN TRAN
PRINT 'Outer Transaction = ' + 
      CONVERT(varchar, @@TRANCOUNT)
DELETE 班級備份
  BEGIN TRAN
  PRINT 'Inner Transaction = ' + 
  CONVERT(varchar, @@TRANCOUNT)
  DELETE 學生備份
  COMMIT TRAN
  PRINT 'Commited Transaction = ' + 
  CONVERT(varchar, @@TRANCOUNT)
ROLLBACK TRAN
PRINT 'Rolled Back Transaction = ' + 
       CONVERT(varchar, @@TRANCOUNT)

















