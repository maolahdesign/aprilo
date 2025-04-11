USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
sum = 0
for i in range(11):
    sum = sum + i
print("Á`©M = " + str(sum))
'
GO  


