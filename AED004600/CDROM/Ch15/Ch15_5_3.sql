USE 教務系統 
GO
DECLARE 學生_資料指標_KEYSET CURSOR
KEYSET
FOR SELECT 學號, 姓名, 電話 FROM 學生 
    WHERE 性別 = '男'
OPEN 學生_資料指標_KEYSET
DECLARE @id char(5)
DECLARE @name varchar(10)
DECLARE @tel varchar(15)
FETCH FIRST FROM 學生_資料指標_KEYSET 
INTO @id, @name, @tel
WHILE @@FETCH_STATUS <> -1
BEGIN
    IF @@FETCH_STATUS = -2
         PRINT 'Missing Record.'
    PRINT @id + ' - ' + @name + ' - ' + @tel
    FETCH NEXT FROM 學生_資料指標_KEYSET
    INTO @id, @name, @tel
END
CLOSE 學生_資料指標_KEYSET
DEALLOCATE 學生_資料指標_KEYSET












