USE 教務系統  
GO
CREATE VIEW 高薪員工_檢視
WITH ENCRYPTION
AS
SELECT * FROM 員工
WHERE 薪水 > 50000
GO
SELECT * FROM 高薪員工_檢視




 































































