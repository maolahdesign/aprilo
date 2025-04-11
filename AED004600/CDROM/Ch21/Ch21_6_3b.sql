USE AdventureWorks 
GO
SELECT R_Table.RANK,L_Table.ProductModelID, L_Table.Name
FROM Production.ProductModel L_Table
INNER JOIN CONTAINSTABLE(Production.ProductModel, 
     Instructions, 'ISABOUT (washer WEIGHT (1.0),
         weld WEIGHT (0.5), polish WEIGHT (0.1))') R_Table
     ON L_Table.ProductModelID = R_Table.[KEY]
ORDER BY R_Table.RANK DESC




