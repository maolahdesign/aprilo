USE 教務系統
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
import pandas as pd
s =  {"col1": ["Mary"],"col2": ["Joe"],"col3": ["Jason"]}
OutputDataSet = pd.DataFrame(s)
',
@input_data_1 = N''  
WITH RESULT SETS (([玩家1] varchar(10),[玩家2] varchar(10),
                     [玩家3] varchar(10)));    
GO  


