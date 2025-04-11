USE 教務系統 
GO
CREATE FUNCTION fnVolume
  (@length decimal(5,2),
   @width decimal(5,2),
   @height decimal(5,2))
  RETURNS decimal(15, 4)
BEGIN
 RETURN (@height * @length * @width)
END
GO
CREATE TABLE 包裝容器 (
   容器編號 char(5) NOT NULL PRIMARY KEY,
   名稱     varchar(20),
   長度     decimal(5,2),
   寬度     decimal(5,2),
   高度     decimal(5,2),
   容量 AS dbo.fnVolume(長度, 寬度, 高度)
)
