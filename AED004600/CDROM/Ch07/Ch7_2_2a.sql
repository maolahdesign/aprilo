USE 教務系統 
GO
CREATE TABLE 課程 (
   課程編號  char(5)    NOT NULL PRIMARY KEY ,
   名稱      varchar(30) NOT NULL ,
   學分      int         DEFAULT 3
)
