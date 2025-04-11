import pymssql

db = pymssql.connect(server='localhost',
                     user='MyDB',
                     password='Aa123456',
                     database='教務系統')
cursor = db.cursor()
sql = """UPDATE 學生 SET 電話='02-44444444', 
         生日='2003-08-01' 
         WHERE 學號='S600' """
sql2 = """UPDATE 學生 SET 電話='02-55555555', 
         生日='2003-03-01' 
         WHERE 學號='S700' """
print(sql)
print(sql2)
try:
    cursor.execute(sql)
    cursor.execute(sql2)
    db.commit()
    print("更新 2 筆記錄...")
except:
    db.rollback()
    print("更新記錄失敗...")
db.close() 
