USE AdventureWorks2019
GO
CREATE PROCEDURE uspGetAllSalesTransactions
AS
SELECT * FROM Sales.SalesOrderHeader SH
INNER JOIN Sales.SalesOrderDetail SD ON SH.SalesOrderID = SD.SalesOrderID
GO
CREATE PROCEDURE uspGetSalesTransactions @SalesOrderID INT
AS
SELECT * FROM Sales.SalesOrderHeader SH
INNER JOIN Sales.SalesOrderDetail SD ON SH.SalesOrderID = SD.SalesOrderID
WHERE SH.SalesOrderID = @SalesOrderID
GO
CREATE PROCEDURE uspGetSalesLineTotalSum
AS
SELECT SalesOrderID, SUM(SD.LineTotal)
FROM Sales.SalesOrderDetail SD
GROUP BY SalesOrderID
GO


DECLARE @counter int = 1
DECLARE @executioncount int = 50
WHILE @counter <= @executioncount
BEGIN
EXEC uspGetAllSalesTransactions
EXEC uspGetSalesTransactions 43666
EXEC uspGetSalesTransactions 43674
EXEC uspGetSalesTransactions 73837
EXEC uspGetSalesLineTotalSum
SET @counter += 1
END