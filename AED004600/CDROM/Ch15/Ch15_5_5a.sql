USE 教務系統 
GO
CREATE PROCEDURE 傳回課程指標
  @課程指標 cursor VARYING OUTPUT
AS 
SET @課程指標= CURSOR 
   LOCAL STATIC
   FOR SELECT * FROM 課程
OPEN @課程指標
GO
DECLARE @course_cur cursor
EXEC 傳回課程指標 @course_cur OUTPUT
FETCH FROM @course_cur 















