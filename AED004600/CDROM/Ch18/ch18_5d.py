import pymssql

db = pymssql.connect(server='localhost',
                     user='MyDB',
                     password='Aa123456',
                     database='教務系統')
cursor = db.cursor()
sql = "DELETE FROM 學生 WHERE 學號='S600'"
sql2 = "DELETE FROM 學生 WHERE 學號='S700'"
print(sql)
print(sql2)
try:
    cursor.execute(sql) 
    cursor.execute(sql2)
    db.commit()
    print("刪除 2 筆記錄...")
except:
    db.rollback()
    print("刪除記錄失敗...")
db.close() 
