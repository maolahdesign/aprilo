USE 教務系統 
GO
DECLARE @MyRowCount int, @MyIdentity int
INSERT 課程備份2
SELECT 課程編號, 名稱, 學分 FROM 課程 
WHERE 學分 >= 4
SET @MyRowCount = @@ROWCOUNT
SET @MyIdentity = @@IDENTITY
SELECT @MyRowCount AS 影響的記錄數, 
       @@SERVERNAME AS 伺服器名稱,
       @MyIdentity AS 自動編號,
       @@ERROR AS 錯誤編號








 































































