# 02GetSettings.ps1
Invoke-Expression (Join-Path (Split-Path $MyInvocation.MyCommand.Path) '範例程式碼16-5：宣告與設定通用的變數.ps1')

# Text Driver
# databases.txt 檔案內容如下：
# Northwind
# AdventureWorks
Push-Location
# 呈現檔案內每一行的內容
get-Content ($scriptPath + "\databases.txt") | foreach {write-Host "操作資料庫 " $_ }
# 例如，使用 SQL Server提供的 Provider，表列資料庫內的資料表
get-Content ($scriptPath + "\databases.txt") | foreach `
{CD sqlserver:\sql\$machineName\$instanceName\databases\$_\tables; `
write-Host "資料庫內的資料表：" $_ ; DIR | Where {$_.Name -like ‘t*’} | MORE;}
Pop-Location

#  透過 XML Driver 讀取 XML 文檔內容
$doc = [xml]( get-Content ($scriptPath + "\Objects.xml") )
# 透過 XML DOM 取得節點內容：
$doc.SelectNodes('//servers/server[@servername="SQL2022"]/databases').InnerXML
# 透過 XML DOM 取得節點內容：
$doc.SelectNodes('//servers/server[@servername="SQL2022"]/databases/database[@databasename="dbDemo"]/table')
# 遞迴表列節點...
foreach ($database in $doc.SelectNodes("//servers/server/databases/database")) {$database.databasename}

#透過 ConvertFrom-Json 讀取 Json 內容，再返序列化回物件
$json=(gc ($scriptPath + "\Objects.json"))  | ConvertFrom-Json 
#以物件集合屬性來讀取 Json
$json.Servers[0].Databases[1] 
