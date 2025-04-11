USE 教務系統 
GO
DECLARE 員工_資料指標 CURSOR
STATIC
FOR SELECT 姓名 FROM 員工
OPEN 員工_資料指標
DECLARE @name varchar(10), @inc int
IF @@CURSOR_ROWS > 0
BEGIN
   SET @inc = @@CURSOR_ROWS / 3
   FETCH NEXT FROM 員工_資料指標 INTO @name
   WHILE @@FETCH_STATUS = 0
   BEGIN
     PRINT @name
     FETCH RELATIVE @inc FROM 員工_資料指標
     INTO @name
   END
END 
CLOSE 員工_資料指標
DEALLOCATE 員工_資料指標













