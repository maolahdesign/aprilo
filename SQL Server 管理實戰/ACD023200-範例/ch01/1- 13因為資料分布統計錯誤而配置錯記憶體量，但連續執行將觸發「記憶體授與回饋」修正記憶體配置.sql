use queryStoreHint

alter database querystorehint set query_store clear all;
go
alter database scoped configuration clear procedure_cache;
go

/*
--讓資料量更大一下
insert tb(c2) select c2 from tb
go 9
*/
--故意讓統計錯誤，使 sql server 配錯記憶體
update statistics tb with rowcount = 1;
GO


--呈現執行後執行計畫，spill 造成大量的 workfile 或 worktable
set statistics io,time on
/*
資料表 'Worktable'。掃描計數 0，邏輯讀取 0，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 12219，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
資料表 'tb'。掃描計數 1，邏輯讀取 6520，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。

(1 個資料列受到影響)

 SQL Server 執行次數: 
，CPU 時間 = 719 ms，經過時間 = 934 ms。
*/
SELECT count(*),sum(c2),c3 from tb group by c3
GO

--執行第二次就因為記憶體授與回饋而不再 spill
/*
(12 個資料列受到影響)
資料表 'Worktable'。掃描計數 0，邏輯讀取 0，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。
資料表 'tb'。掃描計數 1，邏輯讀取 6520，實體讀取 0，頁面伺服器讀取 0，讀取前讀取 0，頁面伺服器讀取前讀取 0，LOB 邏輯讀取 0，LOB 實體讀取 0，LOB 頁面伺服器讀取 0，LOB 讀取前讀取 0，LOB 頁面伺服器讀取前讀取 0。

(1 個資料列受到影響)

 SQL Server 執行次數: 
，CPU 時間 = 500 ms，經過時間 = 522 ms。
*/
SELECT count(*),sum(c2),c3 from tb group by c3
GO
select * from  sys.query_store_plan_feedback  --Memory Grant Feedback	[{"NodeId":"0","AdditionalMemoryKB":"624312"}]
select * from sys.query_store_plan

--執行第二次觸發調整記憶體後，也自動將 Memory Grant Feedback 放入 Query store 讓下次重啟 SQL Server 或清空 plan cache 後，仍可以重複使用這個 feedback 的結果
SELECT qpf.feature_desc, qpf.feedback_data, qpf.state_desc, qt.query_sql_text, (qrs.last_query_max_used_memory * 8192)/1024 as last_query_memory_kb 
FROM sys.query_store_plan_feedback qpf
JOIN sys.query_store_plan qp
ON qpf.plan_id = qp.plan_id
JOIN sys.query_store_query qq
ON qp.query_id = qq.query_id
JOIN sys.query_store_query_text qt
ON qq.query_text_id = qt.query_text_id
JOIN sys.query_store_runtime_stats qrs
ON qp.plan_id = qrs.plan_id;
GO

--要確定有 hint，似乎也有可能重複執行幾次，有快取 plan，但沒有存 hint
--清空 plan cache 後，仍可以重複使用 feedback 的結果，依然不會 spill
--但執行後執行計畫的 select operator 的 MemoryGrantInfo/IsMemoryGrantFeedbackAdjusted 屬性不再出現，
--因為是採用 Query Store 的 hint 而非 Cached plan 內參考的 Memory grant feedback
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
