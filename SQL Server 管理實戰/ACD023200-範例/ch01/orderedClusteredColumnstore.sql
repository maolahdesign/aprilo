drop table if exists tbTest
go

select top(100*1024*1024) 
row_number() over(order by (select null)) id, a.name,d.value
into tbTest
from GENERATE_SERIES(1, 100) d,sys.objects a,sys.objects b,sys.objects c

create clustered columnstore index  cciIdx on tbTest
--with (drop_existing=on,maxdop=1)

SELECT
	partitions.partition_number,
	column_store_segments.segment_id,
	column_store_segments.min_data_id,
	column_store_segments.max_data_id,
	column_store_segments.row_count
FROM sys.column_store_segments
INNER JOIN sys.partitions
ON column_store_segments.hobt_id = partitions.hobt_id
INNER JOIN sys.indexes
ON indexes.index_id = partitions.index_id
AND indexes.object_id = partitions.object_id
INNER JOIN sys.tables
ON tables.object_id = indexes.object_id
INNER JOIN sys.columns
ON tables.object_id = columns.object_id
AND column_store_segments.column_id = 
     columns.column_id
WHERE columns.name = 'value'
ORDER BY column_store_segments.segment_id;

set statistics io,time on
/*
資料表 'tbTest'。掃描計數 12，邏輯讀取 0，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 78065，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
資料表 'tbTest'。區段會讀取 68，略過區段 41。

 SQL Server 執行次數: 
，CPU 時間 = 982 ms，經過時間 = 3760 ms。
*/
select * from tbTest where value=1

--https://www.brentozar.com/archive/2022/07/columnstore-indexes-are-finally-sorted-in-sql-server-2022/
--要用一顆 cpu，且記憶體要夠，否則部分資料先寫入，也就無法整體都排序才寫入
create clustered columnstore index cciIdx on tbTest order(value)
with (drop_existing=on,maxdop=1)

/*
資料表 'tbTest'。掃描計數 12，邏輯讀取 0，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 15620，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
資料表 'tbTest'。區段會讀取 12，略過區段 88。

 SQL Server 執行次數: 
，CPU 時間 = 796 ms，經過時間 = 3480 ms。
*/
select * from tbTest where value=1

