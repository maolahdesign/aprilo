USE 教務系統 
GO
CREATE PROCEDURE 新增課程
   @c_no char(5),
   @title  varchar(30),
   @credits int
AS
BEGIN
  DECLARE @errorNo int
  INSERT INTO 課程 
  VALUES (@c_no, @title, @credits)
  SET @errorNo = @@ERROR
  IF @errorNo <> 0
  BEGIN
    IF @errorNo = 2627
       PRINT '錯誤! 重複索引鍵!'
    ELSE
       PRINT '錯誤! 未知錯誤發生!'
    RETURN @errorNO
  END
END

