USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
cels = 25
fahr = cels * 9 /5 + 32
print(cels, " = ", fahr)
'
GO  


