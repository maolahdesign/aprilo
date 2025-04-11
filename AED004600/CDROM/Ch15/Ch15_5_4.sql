USE 教務系統
GO 
DECLARE 員工_資料指標 CURSOR
LOCAL SCROLL_LOCKS
FOR SELECT 薪水 FROM 員工
    WHERE 員工.姓名 
    NOT IN (SELECT 姓名 FROM 學生)
FOR UPDATE OF 薪水
OPEN 員工_資料指標
DECLARE @salary money
FETCH NEXT FROM 員工_資料指標 INTO @salary
WHILE @@FETCH_STATUS = 0
BEGIN
   IF @salary <= 50000
   BEGIN
      SET @salary = @salary * 1.05
      UPDATE 員工
      SET 薪水 = @salary
      WHERE CURRENT OF 員工_資料指標
   END 
   FETCH NEXT FROM 員工_資料指標 INTO @salary
END
CLOSE 員工_資料指標
DEALLOCATE 員工_資料指標













