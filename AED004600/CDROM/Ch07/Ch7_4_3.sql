USE 教務系統 
GO
ALTER TABLE 員工
   ADD CONSTRAINT 薪水_條件
        CHECK (薪水 > 18000)


