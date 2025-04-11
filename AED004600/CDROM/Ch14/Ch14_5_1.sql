USE 教務系統 
GO
ALTER PROCEDURE 課程資料報表 AS
BEGIN
  SELECT 課程編號, 名稱, 學分
  FROM 課程
  WHERE 學分 > 3
END
GO
EXEC 課程資料報表
