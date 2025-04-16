-- 沒有 WINDOW 子句
select * from (
select salesorderid, productid, orderqty
    ,sum(orderqty) over (partition by salesorderid order by salesorderid, productid ) as total
    ,avg(orderqty) over (partition by salesorderid order by salesorderid, productid) as "avg"
    ,count(orderqty) over (partition by salesorderid order by salesorderid, productid) as "count"
from sales.salesorderdetail
where salesorderid in(43659,43664)) t where [count]<6
go

-- 搭配 window 子句，需要資料庫相容性調到 160
select * from (
select salesorderid, productid, orderqty
    ,sum(orderqty) over win1 as total
    ,avg(orderqty) over win1 as "avg"
    ,count(orderqty) over win1 as "count"
from sales.salesorderdetail
where salesorderid in(43659,43664)
window win1 as (partition by salesorderid order by salesorderid, productid )) t where [count]<6
