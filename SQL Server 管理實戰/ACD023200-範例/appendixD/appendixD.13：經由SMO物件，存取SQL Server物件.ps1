. ('C:\BookSamples\SQL2022Management\Chap16\範例程式碼16-5：宣告與設定通用的變數.ps1')

$sqlServer = new-object ("Microsoft.SqlServer.Management.Smo.Server") "$machineName"
# 表列所有的資料庫
foreach($sqlDatabase in $sqlServer.databases) {$sqlDatabase.name}
# 檢視可以操作的物件屬性方法
$sqlServer | get-member | ConvertTo-Html -property Name, MemberType, Definition -body "Microsoft.SqlServer.Management.Smo.Server 類別" -title "Smo.Server 類別的屬性方法" | Out-File C:\temp\SmoServer.htm
# 將前十名的資料表名稱輸出到檔案
$sqlServer.Databases["Northwind"].Tables | sort -property rowcount -desc | Select-Object -First 10 | Format-Table schema, name, rowcount -AutoSize | out-File C:\temp\TopTenTables.txt

.'C:\temp\TopTenTables.txt' 
