#01SetupEnv.ps1
# 設定發生錯誤後，要如何進行，可以設定：continue(預設)、silentlycontinue 以及 stop 
$ErrorActionPreference = 'Stop'
#先嘗試載入 sqlserver module 再嘗試載入 sqlps，若都不存在，就丟出錯誤
Import-Module 'sqlserver' -ErrorAction SilentlyContinue;
if( !(Get-Module | where {$_.name -eq 'sqlserver'}))
{ 
	Import-Module 'sqlps' -DisableNameChecking -ErrorAction SilentlyContinue -WarningAction SilentlyContinue ;

	if( !(Get-Module | where {$_.name -eq 'sqlps'}))
	{   #丟出例外，停止執行
		throw '未安裝 sqlps 或 sqlserver 模組' 
	}
}

# 設定通用的變數
Set-Variable -scope Global -name machineName -Value "$env:ComputerName"; 
#透過 $env: 命名空間，取得系統環境變數 ComputerName 的值，也就是本機電腦名稱
# 預設的執行個體名稱可用 Default
Set-Variable -scope Global -name instanceName -Value "Default";
Set-Variable -scope Global -name scriptPath -Value 'C:\BookSamples\SQL2022Management\appendixD'
