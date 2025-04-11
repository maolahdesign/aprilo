USE 教務系統
GO
DECLARE @mySalary money
EXEC 薪水查詢 '張無忌', @salary = @mySalary OUTPUT
PRINT 'Joe”s薪水:' + CONVERT(varchar, @mySalary)
