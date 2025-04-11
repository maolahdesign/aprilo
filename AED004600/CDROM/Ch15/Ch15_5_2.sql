USE 教務系統 
GO
DECLARE 學生_資料指標 CURSOR
STATIC
FOR SELECT 學號, 姓名, 電話 FROM 學生 
    WHERE 性別 = '男'
DECLARE @id char(5)
DECLARE @name varchar(10)
DECLARE @tel varchar(15)
OPEN 學生_資料指標
FETCH NEXT FROM 學生_資料指標 INTO @id, @name, @tel
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @id + ' - ' + @name + ' - ' + @tel
    FETCH NEXT FROM 學生_資料指標 INTO @id, @name, @tel
END
CLOSE 學生_資料指標
DEALLOCATE 學生_資料指標











