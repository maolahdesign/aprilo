USE 教務系統 
GO
SELECT COUNT(*) AS 選課數 FROM 班級 
WHERE 學號 = 
(SELECT 學號 FROM 學生 WHERE 姓名='陳會安')












































