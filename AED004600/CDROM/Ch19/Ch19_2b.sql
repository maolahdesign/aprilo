USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'print("Welcome to Python in SQL Server")'
GO  


