from tkinter import ttk
import tkinter as tk
import pymssql

def display_data():
    db = pymssql.connect(server='localhost',
                         user='MyDB',
                         password='Aa123456',
                         database='教務系統')
    cursor = db.cursor()
    sql = "SELECT * FROM 學生"
    cursor.execute(sql)
    rows = cursor.fetchall() 
    for row in rows:
        row_tuple = (row[0], 
                     row[1].encode('latin1').decode('big5'),
                     row[2].encode('latin1').decode('big5')) 
        tree.insert("", tk.END, values=row_tuple)  
    
    db.close()

win = tk.Tk()
win.title("學生資料")
tree = ttk.Treeview(win, column=("C1","C2","C3"), show='headings')
tree.column("#1", anchor=tk.CENTER)
tree.heading("#1", text="學號")
tree.column("#2", anchor=tk.CENTER)
tree.heading("#2", text="姓名")
tree.column("#3", anchor=tk.CENTER)
tree.heading("#3", text="性別")
tree.pack()

button1 = tk.Button(text="顯示資料", command=display_data)
button1.pack(pady=10)
win.mainloop()
