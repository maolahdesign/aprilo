USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
import sys

print(sys.version)
'
GO  


