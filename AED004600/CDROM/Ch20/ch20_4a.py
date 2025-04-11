import pymssql

# 設定連線資訊
server = 'localhost'
user = 'MyDB'
password = 'Aa123456'
database = '教務系統'

# 設定字符集編碼
charset = 'utf8'

# 連接到資料庫
conn = pymssql.connect(server=server, user=user, password=password, database=database, charset=charset)

# 執行T-SQL指令
with conn.cursor(as_dict=True) as cursor:
    cursor.execute('SELECT 課程編號, 名稱, 學分 FROM 課程 WHERE 學分 >= 3')
    rows = cursor.fetchall()

    # 顯示查詢結果
    for row in rows:
        print(row['課程編號'], row['名稱'].encode('iso-8859-1').decode('cp950'), row['學分'])

# 關閉連線
conn.close()
