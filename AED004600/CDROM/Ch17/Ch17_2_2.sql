USE 教務系統 
GO
SELECT * INTO 班級備份 
FROM 班級
GO
BEGIN TRAN
DELETE 班級備份
WHERE 學號 = 'S001'
IF @@ROWCOUNT > 5
  BEGIN
    ROLLBACK TRAN
    PRINT '回復刪除操作!'
  END
ELSE
  BEGIN
    DELETE 學生備份
    WHERE 學號 = 'S001'
    COMMIT TRAN
    PRINT '認可刪除操作!'
  END

















