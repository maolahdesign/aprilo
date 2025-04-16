# 載入 SQL Server Module
Import-Module "sqlps" -DisableNameChecking
#取得叫起 ps1 script 執行的檔案路徑
$path=split-path $MyInvocation.MyCommand.Path
gc "$path\Servers.txt" | `
% { Invoke-SQLCmd -Server $_ -Query "select @@servername as [Server], count(*) as [Blocked]
 from master.dbo.sysprocesses where blocked <> 0" } | `
 ft -AutoSize 
