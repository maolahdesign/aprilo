import pymssql

d = {
   "id": "S700",
   "name": "陳允東",
   "gender": "男",
   "tel": "03-55555555",
   "birthday": "2003-02-01"
}

db = pymssql.connect(server='localhost',
                     user='MyDB',
                     password='Aa123456',
                     database='教務系統')
cursor = db.cursor()
sql = """INSERT INTO 學生 (學號,姓名,性別,電話,生日)
         VALUES ('{0}','{1}','{2}','{3}','{4}')"""
sql = sql.format(d['id'],d['name'],d['gender'],d['tel'],d['birthday'])
print(sql)
try:
    cursor.execute(sql) 
    db.commit()
    print("新增一筆記錄...")
except:
    db.rollback()
    print("新增記錄失敗...")
db.close() 
