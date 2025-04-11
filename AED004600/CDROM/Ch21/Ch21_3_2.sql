USE AdventureWorks
GO
CREATE FULLTEXT INDEX ON Production.Document
(DocumentSummary, Document TYPE COLUMN FileExtension)
KEY INDEX PK_Document_DocumentNode
ON 產品文件_全文檢索目錄
WITH CHANGE_TRACKING AUTO
