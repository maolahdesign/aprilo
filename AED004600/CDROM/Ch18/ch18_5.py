import pymssql

db = pymssql.connect(server='localhost',
                     user='MyDB',
                     password='Aa123456',
                     database='教務系統')
cursor = db.cursor()
sql = "SELECT * FROM 學生 WHERE 生日 <=%s"
cursor.execute(sql, "2003/6/1")
row = cursor.fetchone()
print(row[0], row[1].encode('latin1').decode('big5'))
print("-------------------------")      
data = cursor.fetchall()
for row in data:
    print(row[0], row[1].encode('latin1').decode('big5'))
db.close()

