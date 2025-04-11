USE 教務系統
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
import pandas as pd

products = {"分類": ["居家","居家","娛樂","娛樂","科技","科技"],
            "商店": ["家樂福","大潤發","家樂福","全聯超","大潤發","家樂福"],
            "價格": [11.42,23.50,19.99,15.95,55.75,111.55]}
     
df = pd.DataFrame(products) 
print(df)
' 
GO  


