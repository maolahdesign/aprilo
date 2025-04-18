<#
範例步驟：
建立個別複本上的端點
備份 MyDatabase 及其交易記錄。
使用 MyDatabase 選項還原 -NoRecovery 和其交易記錄。
建立主要複本，此主要複本將由 SQL Server 本機執行個體 (名為 N1\Default) 所裝載。
建立次要複本，此次要複本將由 SQL Server 執行個體 (名為 N2\Default, N3\Default) 所裝載。
建立名為 PoserShellAG 的可用性群組。
將次要複本聯結至可用性群組。
將次要資料庫加入可用性群組。
#>
param(
[string]$AgName='PowerShellAG'
[string[]]$DBs= @('Northwind','myDB')
[string]$ShareFolder='\\N1\DB'
[string]$MainInstance='N1'
[string[]]$Replicas=@('N2','N3')
[string]$Domain='i.com'
[int]$Port=5022
[bool]$CreateEndpoint=$true  #定義是否要建 EndPoint
)
Import-Module sqlps
$DomainPort=$Domain + ':' + $Port.ToString()
# 對每一個執行個體建立端點
if($CreateEndpoint -eq $true)
{
    $endpoint = New-SqlHadrEndpoint AG -Port $Port -Path "SQLSERVER:\SQL\$MainInstance\Default" 
    # 啟動 EndPoint  
    Set-SqlHadrEndpoint -InputObject $endpoint -State "Started"  
    foreach($i in $Replicas)
    {  
        $endpoint = New-SqlHadrEndpoint AG -Port $Port -Path "SQLSERVER:\SQL\$i\Default" 
        # 啟動 EndPoint  
        Set-SqlHadrEndpoint -InputObject $endpoint -State "Started"  
    }
}
# 完整與紀錄備份主要執行個體的資料庫
foreach($db in $DBs)
{
    Backup-SqlDatabase -Database $db -BackupFile "$ShareFolder\$db.bak" -ServerInstance $MainInstance -Initialize
    Backup-SqlDatabase -Database $db -BackupFile "$ShareFolder\$db.log" -ServerInstance $MainInstance -BackupAction Log -Initialize  
}  
'完成備份'
# 使用 No Recovery 還原到其他參與 AG 的執行個體  
foreach($i in $Replicas)
{
    foreach($db in $DBs)
    {
        Restore-SqlDatabase -Database $db -BackupFile "$ShareFolder\$db.bak" `
            -ServerInstance $i -NoRecovery  
        Restore-SqlDatabase -Database $db -BackupFile "$ShareFolder\$db.log" `
            -ServerInstance $i -RestoreAction Log -NoRecovery  
    }
}
'完成還原'
# 建立主要副本定義，AVersion 參數對應的是 SQL 主版號  
$primaryReplica = New-SqlAvailabilityReplica -Name $MainInstance -EndpointURL "TCP://$MainInstance.$DomainPort" `
    -AvailabilityMode 'SynchronousCommit' -FailoverMode 'Automatic' -Version 15 -AsTemplate  
  
# 建立次要副本定義
[System.Collections.ArrayList]$ReplicaTemplates=New-Object System.Collections.ArrayList
[void]$ReplicaTemplates.Add($primaryReplica)
foreach($i in $Replicas)
{
    $secondaryReplica = New-SqlAvailabilityReplica -Name $i -EndpointURL "TCP://$i.$DomainPort" `
      -AvailabilityMode "SynchronousCommit" -FailoverMode "Automatic" -Version 15 -AsTemplate  
    [void]$ReplicaTemplates.Add($secondaryReplica)
}
'完成主/次要副本定義' 
# 建立 availability group  
New-SqlAvailabilityGroup -Name $AGName -Path "SQLSERVER:\SQL\$MainInstance\default" `
   -AvailabilityReplica $ReplicaTemplates -Database $DBs  
'主要副本建立 AG'  
# 將次要副本加入到 availability group
foreach($i in $Replicas)
{
   Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\$i\default" -Name $AGName 
n-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\$i\default" -Name $AGName  
      # 將次要資料庫加入到 availability group
    Add-SqlAvailabilityDatabase -Path "SQLSERVER:\SQL\$i\default\AvailabilityGroups\$AGName" -Database $DBs 
} 
'次要副本加入 AG 並同步資料' 
