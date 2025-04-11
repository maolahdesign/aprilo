USE 教務系統 
GO
CREATE TABLE 訂單明細 (
   訂單編號   int       NOT NULL, 
   項目序號   smallint  NOT NULL,
   數量       int       DEFAULT 1,
   PRIMARY KEY (訂單編號, 項目序號)
)



