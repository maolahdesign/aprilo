USE 教務系統 
GO
SELECT 教授編號, 學號, 課程編號, 教室,
      DATEPART(Hour, 上課時間) AS 小時,
      DATEPART(Minute, 上課時間) AS 分鐘
FROM 班級
WHERE DATEPART(Hour, 上課時間) <= 12













 































































