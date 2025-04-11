USE 教務系統
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
MyOutput = MyInput
', 
@input_data_1_name = N'MyInput',
@input_data_1 = N'SELECT Count(*) FROM 學生',
@output_data_1_name = N'MyOutput'
WITH RESULT SETS (([學生數] int));
GO  


