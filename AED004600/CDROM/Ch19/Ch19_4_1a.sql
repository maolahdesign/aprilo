USE 教務系統
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
OutputDataSet = InputDataSet
', 
@input_data_1 = N'SELECT 課程編號, dbo.UnicodeString(名稱) AS 名稱, 學分 FROM 課程'
GO  


