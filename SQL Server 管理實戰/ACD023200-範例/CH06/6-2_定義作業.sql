--範例程式碼6-1：查詢類別目錄所擁有的作業清單
SELECT c.Name as 類別目錄 ,j.* 
FROM msdb.dbo.syscategories c
JOIN msdb.dbo.sysjobs j ON  j.category_id =c.category_id
WHERE c.Name='日常維護'



--範例程式碼6-2：建立參數表
USE [Northwind]
GO
 
DROP TABLE IF EXISTS ETL

CREATE TABLE [dbo].[ETL](
	[Name] [nvarchar](30) NULL,
	[Type] [varchar](10) NULL,
	[Status] [char](1) NULL,
	[UpdDate] [smalldatetime] NULL
)
GO

INSERT ETL
VALUES('Sales Totals by Amount','VIEW','Y',GETDATE())

GO
--建立目標資料庫
CREATE Database ReportDB


--範例程式碼6-3：轉檔指令碼

IF EXISTS( SELECT [Status] FROM Northwind.dbo.ETL WHERE NAME='Sales Totals by Amount' AND Status='Y' ) 
BEGIN
	DROP TABLE IF EXISTS [Sales Totals by Amount]
	SELECT * INTO [Sales Totals by Amount]  FROM Northwind.dbo.[Sales Totals by Amount]
END
ELSE 
RAISERROR(N'來源端資料尚未關帳',16,1,N'number',5)


 