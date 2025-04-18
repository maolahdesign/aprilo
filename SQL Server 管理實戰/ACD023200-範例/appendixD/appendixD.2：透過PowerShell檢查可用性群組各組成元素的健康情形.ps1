Param(
$AgName='PowerShellAG'
)
#確定可用性群組的 Primary Replica 是哪一個節點，在該節點上查詢才有意義。要只取名稱字串，所以取到 OwnerNode 物件後，還要取其內的屬性
$Node=(Get-ClusterResource | where name -EQ $AgName | select OwnerNode).OwnerNode.Name

Out-Default -InputObject '可用性群組的健全狀況：Test-SqlAvailabilityGroup'
Get-ChildItem "SQLSERVER:\Sql\$Node\default\AvailabilityGroups" | Test-SqlAvailabilityGroup #| Where-Object { $_.HealthState -eq "Error" }

Out-Default -InputObject '可用性複本的健全狀況：Test-SqlAvailabilityReplica'
dir "SQLSERVER:\sql\$Node\default\availabilitygroups\$AgName\availabilityreplicas" | Test-SqlAvailabilityReplica | ft

Out-Default -InputObject '所有聯結可用性複本之可用性資料庫的健全狀況：Test-SqlDatabaseReplicaState'
dir "SQLSERVER:\sql\$Node\default\availabilitygroups\$AgName\DatabaseReplicaStates" | Test-SqlDatabaseReplicaState | ft
