drop table if exists #dataFile
create table #dataFile(
DBName nvarchar(128),
LogicName nvarchar(128),
TotalMB int NOT NULL,
UsedSpaceMB int ,
FreeSpaceMB int ,
type_des varchar(20),
DiskName varchar(10) )
DECLARE @DBName nvarchar(128)
DECLARE curtbls CURSOR
FOR
select name from [sys].[databases]
where state_desc ='ONLINE'
open curtbls
fetch next from curtbls into @DBName
while @@fetch_status=0
begin
DECLARE @SQLScript varchar(max)='
USE ' +@DBName+
' SELECT '''+@DBName+''',
name AS logicName,
size/128.0 [TotalMB] ,
CAST(FILEPROPERTY(name, ''SpaceUsed'') AS int)/128.0 AS UsedSpaceMB
,size/128.0 - CAST(FILEPROPERTY(name, ''SpaceUsed'') AS int)/128.0 FreeSpaceMB
,type_desc,left(physical_name ,1) AS DiskName
FROM '+@DBName+'.sys.database_files;
'
INSERT INTO #dataFile
EXEC (@SQLScript)
PRINT @SQLScript
fetch next from curtbls into @DBName
end
close curtbls
deallocate curtbls
SELECT * FROM #dataFile ORDER BY 4 DESC
