;with tbdate(datetimevalue) --日期資料表，每 12 小時一筆，共 5 天
as
(
select dateadd(hour, value, datetimefromparts(2023,1,1,0,50,20,5))
from generate_series(0, 96,12)
)
select distinct 'year' [時間段單位], date_bucket (year, 1, datetimevalue) [時間值] from tbdate
union all
select distinct 'quarter', date_bucket (quarter, 1, datetimevalue) from tbdate
union all
select distinct 'month', date_bucket (month, 1, datetimevalue) from tbdate
union all
select distinct 'week', date_bucket (week, 1, datetimevalue) from tbdate
union all
select distinct 'day', date_bucket (day, 1, datetimevalue) from tbdate
union all
select distinct 'hour', date_bucket (hour, 1, datetimevalue) from tbdate
union all
select distinct 'minutes', date_bucket (minute, 1, datetimevalue) from tbdate
