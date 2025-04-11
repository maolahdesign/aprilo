USE 教務系統
GO
DECLARE @retVar int
EXEC @retVar = 新增課程 'CS222','資料庫程式設計',3
PRINT '傳回代碼:' + CONVERT(varchar, @retVar)
