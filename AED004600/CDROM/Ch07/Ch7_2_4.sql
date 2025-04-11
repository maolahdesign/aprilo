USE 教務系統 
GO
CREATE TABLE 廠商 (
   廠商編號  int    NOT NULL IDENTITY PRIMARY KEY, 
   廠商名稱  varchar(100),
   分公司數  int    SPARSE
)


