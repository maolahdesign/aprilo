BEGIN TRY
   SELECT 1/0   -- 除以零的錯誤
END TRY
BEGIN CATCH
   THROW 51000, '除以零的錯誤....', 1
END CATCH 


































































