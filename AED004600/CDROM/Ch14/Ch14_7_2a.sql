USE 教務系統 
GO
CREATE TABLE 好客戶 (
   客戶編號 int IDENTITY PRIMARY KEY,
   身份證字號 char(10) NOT NULL,
   姓名 varchar(12) NOT NULL,
   電話 char(12)
)
CREATE TABLE 好員工 (
   員工編號 int IDENTITY PRIMARY KEY,
   姓名 varchar(12) NOT NULL
)
GO