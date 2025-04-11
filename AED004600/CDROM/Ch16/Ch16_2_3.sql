USE 教務系統 
GO
CREATE TRIGGER 檢查上課數
ON 班級 
AFTER INSERT
AS 
BEGIN
  IF ( SELECT COUNT(學號) FROM 班級
      WHERE 學號 = (
        SELECT 學號 FROM Inserted)
     ) > 3
  BEGIN
     RAISERROR('已經修太多課程!',1,1)
     ROLLBACK
  END 
END


