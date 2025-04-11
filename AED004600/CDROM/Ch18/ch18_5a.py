import pymssql

student = "S600,陳允如,女,03-44444444,2003-07-01"
f = student.split(",")

db = pymssql.connect(server='localhost',
                     user='MyDB',
                     password='Aa123456',
                     database='教務系統')
cursor = db.cursor()
sql = """INSERT INTO 學生 (學號,姓名,性別,電話,生日)
         VALUES ('{0}','{1}','{2}','{3}','{4}')"""
sql = sql.format(f[0], f[1], f[2], f[3], f[4])
print(sql)
try:
    cursor.execute(sql)
    db.commit()
    print("新增一筆記錄...")
except:
    db.rollback() 
    print("新增記錄失敗...")
db.close()

