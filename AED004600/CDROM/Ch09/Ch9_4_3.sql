USE 教務系統 
GO
SELECT * FROM 學生 
WHERE EXISTS
(SELECT * FROM 班級 
WHERE 課程編號 = 'CS222' AND 學生.學號 = 班級.學號)















































