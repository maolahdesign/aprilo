USE 教務系統 
GO
UPDATE 客戶 SET
    電話 = '0938000123'
OUTPUT
   Inserted.客戶編號, Inserted.姓名, 
   Inserted.電話 AS 更新後電話, 
   Deleted.電話 AS 更新前電話
WHERE 客戶編號 = 'C001'























































