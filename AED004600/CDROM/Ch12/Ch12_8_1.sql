USE 教務系統 
GO
CREATE TABLE 廠商名單 (
   廠商編號  int    NOT NULL IDENTITY PRIMARY KEY, 
   廠商名稱  varchar(100),
   廠商類型  tinyint  NOT NULL,
   分公司數  int     SPARSE
)
GO
CREATE NONCLUSTERED INDEX 分公司數_索引
ON 廠商名單(分公司數)
WHERE 廠商類型 = 3



















 































































