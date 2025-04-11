USE AdventureWorks
GO
SELECT DocumentNode, DocumentSummary
FROM Production.Document
WHERE CONTAINS (DocumentSummary, '"pa*"')
