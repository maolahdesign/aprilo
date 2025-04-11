USE 教務系統 
GO
CREATE TABLE 員工 (
   身份證字號 char(10)   NOT NULL PRIMARY KEY,
   姓名       varchar(12) NOT NULL,
   城市       varchar(5)  DEFAULT '台北',
   街道       varchar(30),
   電話       char(12),
   薪水       money,
   保險       money,
   扣稅       money
)
