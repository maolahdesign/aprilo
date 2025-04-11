USE 教務系統
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
import pandas as pd

s = pd.Series([12, 29, 72,4, 8, 10]) 
df = pd.DataFrame(s)
OutputDataSet = df
' 
WITH RESULT SETS(([值] int))
GO  


