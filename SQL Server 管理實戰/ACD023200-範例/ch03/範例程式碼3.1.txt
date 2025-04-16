--啟用查詢存放區
USE [Northwind]
GO

--建立測試資料表
CREATE TABLE tbQueryStore (C1 INT, C2  CHAR(10))
go

--新增測試資料
INSERT INTO tbQueryStore 
select [value], CAST([value] AS CHAR(10)) from generate_series(1,10000) --sql 2022 新增的函數
go

--建立索引
CREATE INDEX idx_C1 on tbQueryStore (C1)
go

--建立預儲程序
CREATE OR ALTER PROC sp_QueryStore @v1 int
AS
BEGIN
	SELECT * FROM tbQueryStore WHERE C1 < @v1
END
go

--清除 query store 已經存放的執行計畫
ALTER DATABASE CURRENT SET QUERY_STORE CLEAR ALL;

--顯示IO統計資料
SET STATISTICS IO ON
go

--第一次執行預儲程序select大量資料，執行計畫使用"資料表掃描"
EXEC sp_QueryStore 10000 

/*(9999 個資料列受到影響)
資料表 'tbQueryStore'。掃描計數 1，邏輯讀取 29，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 29，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
*/

--第二次執行預儲程序select少量資料，執行計畫仍使用"資料表掃描"
EXEC sp_QueryStore 10

/*(9 個資料列受到影響)
資料表 'tbQueryStore'。掃描計數 1，邏輯讀取 30，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
*/

--清除計畫快取
DBCC FREEPROCCACHE

--清除計畫快取後，第一次執行預儲程序select少量資料，執行計畫使用"索引搜尋"
EXEC sp_QueryStore 10

/*
(9 個資料列受到影響)
資料表 'tbQueryStore'。掃描計數 1，邏輯讀取 11，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
*/

--清除計畫快取後，第二次執行預儲程序select大量資料，執行計畫使用"索引搜尋"。
--因為執行計畫錯誤，造成大量的邏輯讀取
EXEC sp_QueryStore 10000 
/*
(9999 個資料列受到影響)
資料表 'tbQueryStore'。掃描計數 1，邏輯讀取 10024，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
*/

--查詢已經擷取的執行計畫
select * from sys.query_store_plan
