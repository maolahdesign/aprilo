USE 教務系統 
GO
SELECT DISTINCT 課程.* FROM 課程, 班級
WHERE (班級.教室='221-S' OR 班級.教室='100-M') 
   AND 課程.課程編號=班級.課程編號

















































