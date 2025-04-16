-- is distinct from 指兩個值不同，把 null 都納入比較，就不用再分出 is null 或 is not null
declare @v int=null
;with c(listValue)
as
(select * from (values(1),(null),(2)) t(listValue))
select N'distinct 非...值(NULL)',* from c where listValue is distinct from @v
union all
select N'not distinct 是...值(NULL)',* from c where listValue is not distinct from @v
union all
select N'= (無法與 NULL 比較，全 false 無法回傳)',* from c where listValue = @v
union all
select N'<> (無法與 NULL 比較，全 false 無法回傳)',* from c where listValue <> @v
