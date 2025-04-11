USE 教務系統 
GO
CREATE FUNCTION fnEmployee
    (@m int, @n int)
  RETURNS @outTable TABLE
   ( 編號 int IDENTITY(1,1),
     身份證字號 char(10), 姓名 varchar(12),
     地址 varchar(30), 電話 char(12),
     薪水淨額 money )
BEGIN
  INSERT @outTable
     SELECT 身份證字號, 姓名, 城市+街道,
            電話, 薪水-保險-扣稅
     FROM 員工
  DELETE @outTable
  WHERE 編號 < @m OR 編號 > @n
  RETURN
END

