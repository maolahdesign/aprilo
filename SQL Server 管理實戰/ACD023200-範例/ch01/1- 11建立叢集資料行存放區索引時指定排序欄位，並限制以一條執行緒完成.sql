--https://www.brentozar.com/archive/2022/07/columnstore-indexes-are-finally-sorted-in-sql-server-2022/
--要用一條執行緒，且記憶體要夠，否則部分資料先寫入，也就無法整體都排序才寫入
create clustered columnstore index cciIdx on tbTest order(value)
with (drop_existing=on,maxdop=1)

/*
資料表 'tbTest'。掃描計數 12，邏輯讀取 0，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 15620，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
資料表 'tbTest'。區段會讀取 12，略過區段 88。

 SQL Server 執行次數: 
，CPU 時間 = 796 ms，經過時間 = 3480 ms。
*/
select * from tbTest where value=1
