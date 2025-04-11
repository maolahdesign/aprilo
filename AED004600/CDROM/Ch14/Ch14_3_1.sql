USE 教務系統 
GO
CREATE PROCEDURE 課程查詢
   @c_no char(5)
AS
BEGIN
  SELECT 課程編號, 名稱, 學分
  FROM 課程
  WHERE 課程編號 = @c_no
END
