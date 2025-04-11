USE 教務系統
GO
CREATE TRIGGER 新增課程記錄
ON 課程 
INSTEAD OF INSERT
AS 
BEGIN
IF EXISTS (SELECT * FROM 課程
           WHERE 課程編號 = (
           SELECT 課程編號 FROM Inserted))
  BEGIN 
    UPDATE 課程
    SET 課程.名稱 = Inserted.名稱,
        課程.學分 = Inserted.學分
    FROM 課程 JOIN Inserted
    ON 課程.課程編號 = Inserted.課程編號
    PRINT '更新一筆記錄!'
  END
ELSE
  BEGIN
    INSERT 課程
    SELECT * FROM Inserted
    PRINT '新增一筆記錄!'
  END
END




