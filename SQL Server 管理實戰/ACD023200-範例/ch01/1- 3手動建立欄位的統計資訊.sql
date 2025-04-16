use tempdb
drop table if exists t
go
create table t(c1 int identity,c2 varchar(50))
go
create statistics sta on t(c2)
go
select s.name as statistics_name
      ,c.name as column_name
      ,sc.stats_column_id
from sys.stats as s
inner join sys.stats_columns as sc
    on s.object_id = sc.object_id and s.stats_id = sc.stats_id
inner join sys.columns as c
    on sc.object_id = c.object_id and c.column_id = sc.column_id
where s.object_id = object_id('t');
go
alter table t drop column c2
go
--2022 後可以搭配 auto_drop 選項，在刪除欄位時，自動先刪除自建的統計
create statistics sta on t(c2) with auto_drop = on
