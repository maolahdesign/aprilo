USE 教務系統 
GO
CREATE TRIGGER 新增記錄
ON 課程 
FOR INSERT
AS 
BEGIN
  DECLARE @name varchar(30)
  SELECT @name = 名稱 FROM Inserted
  PRINT '新增課程: ' + @name
END

