. ('C:\BookSamples\SQL2022Management\Chap16\範例程式碼16-5：宣告與設定通用的變數.ps1')

# 你可以結合前一段範例，將下述的結果轉成網頁，或是透過電子郵件寄送...
write-Host "
==============================================================
使用  SQL Server 的 Provider，執行 T-SQL 查詢語法"
CD sqlserver:\sql\$machineName\$instanceName\databases\master\
invoke-SQLCMD -Query "SELECT @@VERSION"  

write-Host "
==============================================================
呈現使用者定義大過某個容量(Kbyte)的資料表，呈現其空間的使用"
CD sqlserver:\sql\$machineName\$instanceName\databases\Northwind\tables
DIR | where-Object {($_.DataSpaceUsed + $_.IndexSpaceUsed) -gt 200} | sort-Object -property DataSpaceUsed | select-Object Name, RowCount, DataSpaceUsed, IndexSpaceUsed

write-Host "
==============================================================
檢查未備份的時間超過一天以上"
CD SQLSERVER:\SQL\$machineName\$instanceName\Databases
DIR | WHERE {((get-date)-($_.LastBackupDate)).days -gt 1} | sort-Object -property LastBackupDate | select-Object LastBackupDate, Name

write-Host "
==============================================================
備份資料庫 Northwind"
if ((Test-Path -Path 'C:\temp\dbBackups') -eq $false) {new-item -type directory -name dbBackups -path 'C:\temp'}
CD sqlserver:\sql\$machineName\$instanceName\databases\
DIR | %{[string]$_.Name + ' 最後備份日期：' + $_.LastBackupDate}
DIR | where{ (((get-date)-($_.LastBackupdate)).days -gt 1) -and $_.name -eq "Northwind"} | `
%{$dbname= $_.Name;write-host "$dbname"; $_.Refresh(); 
invoke-sqlcmd -Server "$machineName"  -query "BACKUP DATABASE [$dbname] TO  DISK = N'C:\temp\dbBackups\$dbname.bak' WITH INIT,COMPRESSION";}

write-Host "
==============================================================
檢查 SQL Error Logs，轉成 HTML"
# web_This "SQLErrors"
(get-item SQLSERVER:\SQL\$machineName\$instanceName).ReadErrorLog() | `
where {$_.Text -like "Start*"} | ConvertTo-Html -property LogDate, ProcessInfo, Text `
-body "執行個體： $machineName\$instanceName" -title "SQL Server Error Logs" | `
Out-File C:\temp\SQLErrors.htm -Append
#叫起該網頁?
.'C:\temp\SQLErrors.htm'

write-Host "
==============================================================
比較資料庫物件的 Scripts" 
CD SQLSERVER:\SQL\$machineName\$instanceName\Databases\Northwind\Tables
# 將資料表的定義寫入檔案中?
(get-item dbo.Employees).Script() | out-File C:\temp\before.sql
# Time passes, table changes
# 可能會需要更新一下物件定義
# (get-item HumanResources.Employee).Refresh()
invoke-SQLCMD -InputFile C:\BookSamples\SQL2022Management\Chap16\DropCreateEmployee2.sql
# 建立資料表的 T-SQL Script 到檔案中?
(get-item dbo.Employees2).Script() | out-File C:\temp\after.sql
# 比較兩個檔案內容的異同
compare-object (get-content C:\temp\before.sql) (get-content C:\temp\after.sql) -IncludeEqual | out-File C:\temp\CompareResult.txt -Width 200

.'C:\temp\CompareResult.txt' 
