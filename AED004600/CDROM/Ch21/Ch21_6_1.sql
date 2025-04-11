USE AdventureWorks
GO
SELECT DocumentNode, DocumentSummary
FROM Production.Document
WHERE FREETEXT (DocumentSummary, 'replace pedal')
