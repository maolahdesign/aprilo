--範例程式碼6-16：新增資料列，讓資料檔案空間的使用量超過預期的大小

/*
建立資料表並新增大量資料列，讓資料檔案空間的使用量增大
*/
--建立資料表
CREATE TABLE Northwind.dbo.tb1
(CH char(8000))
GO

--新增 1000 筆資料列
INSERT Northwind.dbo.tb1
	VALUES (CAST(SYSDATETIME() AS varchar(50))+'_'+APP_NAME())
GO 1000
