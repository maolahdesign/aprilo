USE AdventureWorks
GO
SELECT R_Table.RANK,L_Table.ProductModelID, L_Table.Name
FROM Production.ProductModel L_Table
INNER JOIN FREETEXTTABLE(Production.ProductModel, 
     Instructions, 'washer weld polish', LANGUAGE 1033) R_Table
     ON L_Table.ProductModelID = R_Table.[KEY]
ORDER BY R_Table.RANK DESC


