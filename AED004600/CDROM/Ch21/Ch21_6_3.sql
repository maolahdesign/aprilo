USE AdventureWorks
GO
CREATE FULLTEXT INDEX ON Production.ProductModel
(Name, CatalogDescription, Instructions)
KEY INDEX PK_ProductModel_ProductModelID
ON 產品文件_全文檢索目錄
WITH CHANGE_TRACKING AUTO
