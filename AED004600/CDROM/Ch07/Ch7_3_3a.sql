USE 教務系統 
GO
CREATE TABLE 我的訂單 (
   訂單編號   int   NOT NULL IDENTITY PRIMARY KEY, 
   訂單總價   money NOT NULL,
   付款總額   money DEFAULT 0,
   CHECK ( (訂單總價 > 0) AND (付款總額 > 0) 
            AND (訂單總價 > 付款總額))
)





