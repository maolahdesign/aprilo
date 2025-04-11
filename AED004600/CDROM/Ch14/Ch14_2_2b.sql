USE 教務系統 
GO
DECLARE @table_name char(20)
SET @table_name = '學生'
EXEC ('SELECT * FROM ' + @table_name)




