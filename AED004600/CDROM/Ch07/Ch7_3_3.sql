USE 教務系統 
GO
CREATE TABLE 訂單 (
   訂單編號   int   NOT NULL IDENTITY PRIMARY KEY, 
   訂單總價   money NOT NULL 
       CONSTRAINT 訂單總價_條件約束
       CHECK (訂單總價 > 0),
   付款總額   money DEFAULT 0
       CHECK (付款總額 > 0)
)




