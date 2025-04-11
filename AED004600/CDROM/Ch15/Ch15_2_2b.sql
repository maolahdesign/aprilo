USE 教務系統 
GO
SELECT 學生.學號, 學生.姓名, 課程.*, 教授.*
FROM dbo.fnProfessor(500) AS 教授 INNER JOIN
(課程 INNER JOIN 
(學生 INNER JOIN 班級 ON 學生.學號 = 班級.學號) 
ON 班級.課程編號 = 課程.課程編號) 
ON 班級.教授編號 = 教授.教授編號
