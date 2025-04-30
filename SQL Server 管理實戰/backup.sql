-- 完整備份
BACKUP DATABASE maolah
TO maolah_BD
WITH INIT, FORMAT, NAME = 'maolah 初始完整備份'; -- 注意 with init ,Format 會清空之前的備份紀錄

BACKUP DATABASE maolah
TO maolah_BD
WITH NAME = 'maolah 初始完整備份';

-- 差異備份
BACKUP DATABASE maolah
TO maolah_BD
WITH DIFFERENTIAL, NOINIT, NAME = 'maolah 每日差異備份';

-- 交易記錄備份
BACKUP LOG maolah
TO maolah_BD
WITH NAME = 'Electronics3CStore 每小時交易記錄備份';

DECLARE @BackupPath NVARCHAR(500);
DECLARE @DBName NVARCHAR(100) = 'maolah';
DECLARE @DateTime NVARCHAR(20) = REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), ':', ''), ' ', '_');

SET @BackupPath = 'C:\Temp\' + @DBName + '_' + @DateTime + '.trn';

BACKUP LOG maolah
TO DISK = @BackupPath
WITH NAME = 'maolah 每小時交易記錄備份';


-- 監控記錄大小
DBCC SQLPERF(LOGSPACE);