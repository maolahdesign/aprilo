--create database queryStoreHint

alter database queryStoreHint set query_store clear; --清掉 query store 所有內容
alter database current set query_store = on;
alter database current set query_store  (query_capture_mode = all);
GO

use queryStoreHint

-- 應該是 READ_WRITE
select actual_state_desc from sys.database_query_store_options;
go

/*
	一開始清空了，此處應該沒有任何 hint
*/
select	query_hint_id,
        query_id,
        query_hint_text,
        last_query_hint_failure_reason,
        last_query_hint_failure_reason_desc,
        query_hint_failure_count,
        source,
        source_desc
from sys.query_store_query_hints;
go
/*
drop table if exists tb
--建立測試資料
create table tb(pk int identity primary key,
c2 int,
c3 datetime2(7) default(sysdatetime()))
go
insert tb(c2) values(1)
go
insert tb(c2) select c2 from tb
go 12 --不能超過百萬，否則會造成參數敏感性計畫優化
--要先 insert 再建索引才會統計到 2 這筆紀錄
insert tb(c2) values(2)
create index idx on tb(c2)
select count(*) from tb
go
create or alter proc sp @c2 int
as
	select * from tb where c2=@c2
go
*/

--	 1 有4千筆，2有 1 筆
select	hist.range_high_key as [agentid], 
        hist.equal_rows
from sys.stats as s
cross apply sys.dm_db_stats_histogram(s.[object_id], s.stats_id) as hist
where s.name = 'idx'
go

-- 執行前點選呈現執行後執行計畫，檢視使用的執行計畫差異
-- 叢集索引掃描
exec sp 1;

--alter database scoped configuration clear procedure_cache;
-- 應該用 index seek 後以 key bookmark lookup，若不清空執行計畫，就會沿用舊的 
exec sp 2;
go

/*
    透過 query store 設定 query id 使用的 hint
	以下到 go 一起執行，透過 option(recompile) 要求這個語法一率重新編譯，不用快取執行計畫
*/
declare @query_id int
select @query_id=q.query_id
from sys.query_store_query_text qt 
inner join sys.query_store_query q on 
    qt.query_text_id = q.query_text_id 
where query_sql_text like N'%select * from tb%' and query_sql_text not like N'%query_store%';

select query_sql_text, q.query_id
from sys.query_store_query_text qt 
inner join sys.query_store_query q on 
    qt.query_text_id = q.query_text_id 
where query_sql_text like N'%select * from tb%' and query_sql_text not like N'%query_store%';
/*
	 要以上一段查詢回的 query_id 設定此處的 @query_id
*/
exec sp_query_store_set_hints @query_id=@query_id, @value = N'option(recompile)';
go

/*
   透過 sys.query_store_query_hints 確認 Query Store Hints
*/
SELECT	query_hint_id,
        query_id,
        query_hint_text,
        last_query_hint_failure_reason,
        last_query_hint_failure_reason_desc,
        query_hint_failure_count,
        source,
        source_desc
FROM sys.query_store_query_hints;
GO

--在一次執行，看執行後執行計畫是否
exec sp 1;
exec sp 2;
GO

SELECT	query_hint_id,
        query_id,
        query_hint_text,
        last_query_hint_failure_reason,
        last_query_hint_failure_reason_desc,
        query_hint_failure_count,
        source,
        source_desc
FROM sys.query_store_query_hints;
GO

/*
    透過 sp_query_store_clear_query_hints 移除 query hint 
	要用前面查出來的 query_id
*/
EXEC sp_query_store_clear_hints @query_id = 8;
GO

/*
    確認移除
*/
SELECT	query_hint_id,
        query_id,
        query_hint_text,
        last_query_hint_failure_reason,
        last_query_hint_failure_reason_desc,
        query_hint_failure_count,
        source,
        source_desc
FROM sys.query_store_query_hints;
GO

-- 重新回到沿用前一次執行計畫快取的狀況
EXEC sp 1;
EXEC sp 2;
GO