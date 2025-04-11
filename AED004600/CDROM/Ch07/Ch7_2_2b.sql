USE 教務系統 
GO
CREATE TABLE 教授 (
   建檔編號   int         IDENTITY(1000, 1), 
   教授編號   char(4)     NOT NULL PRIMARY KEY,
   職稱       varchar(10),
   科系       varchar(5),
   身份證字號 char(10)   NOT NULL
)


