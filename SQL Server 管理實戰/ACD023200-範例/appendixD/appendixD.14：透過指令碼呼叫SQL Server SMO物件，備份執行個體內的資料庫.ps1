# 對指定的伺服器執行個體內，所有使用者資料庫先做完整備份，
# 再進行交易紀錄備份
Function Backup($ServerInstance)
{
     [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | out-null 
    $s = new-object ('Microsoft.SqlServer.Management.Smo.Server') "$ServerInstance"
    #備份到 SQL Server 執行個體預設的目錄
    #C:\Program Files\Microsoft SQL Server\<執行個體版本>.MSSQLSERVER\MSSQL\Backup
    $bkdir = $s.Settings.BackupDirectory
    $dbs = $s.Databases
    $dbs | foreach-object {
          $db = $_
          if ($db.IsSystemObject -eq $False) {
            $dbname = $db.Name
            Write-Host "備份資料庫 $dbname"
            $dt = get-date -format yyyyMMddHHmmss
            $dbbk = new-object Microsoft.SqlServer.Management.Smo.Backup 

            $dbbk.Action = "Database"
            $dbbk.BackupSetDescription = $dbname + " 的完整備份"
            $dbbk.BackupSetName = $dbname + " Backup"
            $dbbk.Database = $dbname
            $dbbk.MediaDescription = "Disk"
            $FileName=$bkdir + "\" + $dbname + "_db_" + $dt + ".bak" 
            $dbbk.Devices.AddDevice($FileName, "File")
            #壓縮並初始化
            $dbbk.CompressionOption=[Microsoft.SqlServer.Management.Smo.BackupCompressionOptions]::On
            $dbbk.Initialize=$true
            #產生 Backup 的 T-SQL 語法
            $dbbk.Script($s) | Out-File 'C:\temp\backup.sql' -Append
            #真正執行備份
            $dbbk.SqlBackup($s) 

            # 若 Recovery Model 是 Simple ，則 Value 屬性值是 3
            if ($db.recoverymodel.value__ -ne 3) {
            $dt = get-date -format yyyyMMddHHmmss
            $dbtrn = new-object ("Microsoft.SqlServer.Management.Smo.Backup")
            $dbtrn.Action = "Log"
            $dbtrn.BackupSetDescription = $dbname + " 的交易紀錄備份"
            $dbtrn.BackupSetName = $dbname + " Backup"
            $dbtrn.Database = $dbname
            $dbtrn.MediaDescription = "Disk"
            $dbtrn.Devices.AddDevice($bkdir + "\" + $dbname + "_tlog_" + $dt + ".trn", "File")
            $dbtrn.SqlBackup($s)
              }
          }
        }
}
# 以互動的方式詢問需要備份的 SQL Server 執行個體
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | out-null
$Instance=[Microsoft.VisualBasic.Interaction]::InputBox("請輸入需要備份的 SQL Server 執行個體","執行個體名稱","localhost")
Backup $Instance
