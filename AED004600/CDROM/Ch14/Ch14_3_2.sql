USE 教務系統 
GO
CREATE PROCEDURE 地址查詢
   @city char(5) = '台北',
   @street varchar(30) = '中正路'
AS
BEGIN
  SELECT 身份證字號, 姓名, 
      (薪水-扣稅) AS 所得額, 
      (城市+街道) AS 地址
  FROM 員工
  WHERE 城市 LIKE @city
    AND 街道 LIKE @street
END

