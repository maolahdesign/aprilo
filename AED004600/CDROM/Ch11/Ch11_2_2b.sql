USE 教務系統 
GO
CREATE VIEW 高薪員工聯絡_檢視 
WITH SCHEMABINDING
AS
SELECT 身份證字號, 姓名, 電話 FROM dbo.員工
WHERE 薪水 > 50000
GO
SELECT * FROM 高薪員工聯絡_檢視





 































































