[CmdletBinding()]
param (
    $sqlInstance='localhost'
)
#bcp "exec etlConfig.migrate.spGetRecord @tableName='etl.tbItem', @startDate='20220801'" queryout "C:\temp\etl.tbItem.csv" -T -w -t0x06 -r0x08
#bcp etlConfig.migrate.tbTmp_etl_tbItem in "C:\temp\etl.tbItem.csv" -T -w -t0x06 -r0x05

#在 PowerShell Script 內定義要利用 T-SQL 產生物件定義的集合，再交由 SMO 的 Scripter 產生
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | out-null
#建立連接到某個SQL Server執行個體的SMO.Server物件
$SMOserver = New-Object ('Microsoft.SqlServer.Management.Smo.Server') -argumentlist $sqlInstance

$scriptr = new-object ('Microsoft.SqlServer.Management.Smo.Scripter') ($SMOserver)

#存放定義的目錄結構 C:\temp\database\<Instance>\<date>\<InstanceObjectType>
#或C:\temp\database\<Instance>\<date>\<DatabaseName>\<DatabaseObjectType>
$DateFolder = get-date -format yyyyMMddHHmm
# -replace 用得是 regular expression
$sqlInstance = $sqlInstance -replace "\/|\\|\:","_"
$SavePath = "C:\TEMP\Databases\" + $sqlInstance

new-item -type directory -name "$DateFolder" -path "$SavePath"

#Instance 等級要建立的物件集合
#定義要產生 Script 的集合，再逐一交給 Scripter 產生 T-SQL 語法
$ServerObjects = $SMOServer.Logins
$ServerObjects += $SMOServer.Databases
foreach($ScriptThis in $ServerObjects | where {!($_.IsSystemObject)})
{
        #若存放某種物件型態的目錄不存在，先建立該型態名稱的目錄
        $TypeFolder=$ScriptThis.GetType().Name
        if ((Test-Path -Path "$SavePath\$DateFolder\$TypeFolder") -eq $false)         {new-item -type directory -name "$TypeFolder"-path "$SavePath\$DateFolder"}

        "產出 $TypeFolder $ScriptThis" | Out-Default
        $ScriptFile = $ScriptThis -replace "\[|\]|\\"
        $scriptr.Options.FileName = "$SavePath\$DateFolder\$TypeFolder\$ScriptFile.sql"
        [void]$scriptr.Script($ScriptThis)
}
 
#定義 Scripter 產生資料庫內物件的相關選項
$scriptr.Options.AppendToFile = $True
$scriptr.Options.AllowSystemObjects = $false
$scriptr.Options.ClusteredIndexes = $True
$scriptr.Options.DriAll = $True
$scriptr.Options.ScriptDrops = $False
$scriptr.Options.IncludeHeaders = $True
$scriptr.Options.ToFileOnly = $True
$scriptr.Options.Indexes = $True
$scriptr.Options.Permissions = $True
$scriptr.Options.WithDependencies = $False
foreach($db in $SMOserver.databases)
{
    #不建立系統資料庫物件
    if(-not $db.IsSystemObject)
    {
        #DB 等級要建立的物件
        $Objects = $db.Tables
        $Objects += $db.Views
        $Objects += $db.StoredProcedures
        $Objects += $db.UserDefinedFunctions
        $Objects += $db.Users
        
        #建立目錄結構
        new-item -type directory -name $db.Name -path "C:\TEMP\Databases\$sqlInstance\$DateFolder"
        
        $SavePath = "C:\TEMP\Databases\$sqlInstance\$DateFolder\" + $($db.Name)

        foreach ($ScriptThis in $Objects | where {!($_.IsSystemObject)}) {
            #為不同類型物件建立不同的目錄名稱
            $TypeFolder=$ScriptThis.GetType().Name

            if ((Test-Path -Path "$SavePath\$TypeFolder") -eq $false)
            {new-item -type directory -name "$TypeFolder"-path "$SavePath"}
            
            "產出 $TypeFolder $ScriptThis" | Out-Default
            $ScriptFile = $ScriptThis -replace "\[|\]|\\"
            $scriptr.Options.FileName = "$SavePath\$TypeFolder\$ScriptFile.sql"
            #每次產生一個物件的T-SQL定義
            [void]$scriptr.Script($ScriptThis)
        }
    }
}
