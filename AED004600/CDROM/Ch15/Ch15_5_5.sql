USE 教務系統 
GO
DECLARE @課程指標 cursor
SET @課程指標= CURSOR 
   LOCAL STATIC
   FOR SELECT * FROM 課程
OPEN @課程指標
FETCH FROM @課程指標














