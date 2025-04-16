declare @date datetime = '2023-01-1 13:30:05';
select 'now' as [bucketname], @date as [datebucketvalue]
union all
select 'year', date_bucket (year, 1, @date)
union all
select 'quarter', date_bucket (quarter, 1, @date)
union all
select 'month', date_bucket (month, 1, @date)
union all
select 'week', date_bucket (week, 1, @date)
union all
select 'day', date_bucket (day, 1, @date)
union all
select 'hour', date_bucket (hour, 1, @date)
union all
select 'minutes', date_bucket (minute, 1, @date)
union all
select 'seconds', date_bucket (second, 1, @date);
go


