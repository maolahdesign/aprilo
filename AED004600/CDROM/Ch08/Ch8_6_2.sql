USE 教務系統 
GO
SELECT 學號, 課程編號 FROM 班級 
GROUP BY 課程編號, 學號
HAVING 學號 = 'S002'

































