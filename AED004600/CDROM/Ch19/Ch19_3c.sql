USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
def convert_to_f(c):
    f = (9.0 * c) / 5.0 + 32.0
    return f

cels = 25
fahr = convert_to_f(cels)
print(cels, " = ", fahr)
'
GO  


