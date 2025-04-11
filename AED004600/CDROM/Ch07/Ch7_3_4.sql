USE 教務系統 
GO
CREATE TABLE 班級 (
   教授編號   char(4)  NOT NULL, 
   課程編號   char(5)  NOT NULL,
   學號       char(4)  NOT NULL
              REFERENCES 學生 (學號),
   上課時間   datetime,
   教室       varchar(8), 
   PRIMARY KEY (學號, 教授編號, 課程編號),
   FOREIGN KEY (教授編號) REFERENCES 教授 (教授編號),
   FOREIGN KEY (課程編號) REFERENCES 課程 (課程編號)
)
