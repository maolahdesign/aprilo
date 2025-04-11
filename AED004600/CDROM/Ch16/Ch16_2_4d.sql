CREATE TRIGGER 新增學生員工記錄
ON 學生員工_檢視 
INSTEAD OF INSERT
AS 
DECLARE @rowCount int
SELECt @rowCount = COUNT(*) FROM Inserted
IF @rowCount = 1
  BEGIN
    INSERT 學生
    SELECT 學號, 姓名, 性別, 
           電話, 生日
    FROM Inserted
    INSERT 員工
    SELECT 身份證字號, 姓名, 城市, 街道,
           電話, 薪水, 保險, 扣稅
    FROM Inserted
    PRINT '新增兩筆記錄!'
  END
ELSE
  RAISERROR('錯誤: 只允許能新增一筆記錄.',1,1)




