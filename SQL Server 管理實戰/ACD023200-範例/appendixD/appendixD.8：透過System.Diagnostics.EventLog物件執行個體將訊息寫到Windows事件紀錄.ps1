# 回報紀錄機制
# 事件紀錄(Event Log)
Function log_This 
{
      $log = New-Object System.Diagnostics.EventLog('Application') 
      $log.set_source($log_ApplicationName)
      $log.WriteEntry($log_Message)
}
# 範例 - 呼叫函數傳遞內容時，不用參數只用變數
$log_ApplicationName = "自訂的應用程式名稱"
$log_Message = "輸入需要記錄的資訊"
# 呼叫函數，你可以用系統的事件檢視器檢視結果
log_This

# 讀取事件紀錄：
get-Eventlog application | where-Object {$_.Message -eq "輸入需要記錄的資訊"}
get-Eventlog application | where-Object {$_.source -eq "自訂的應用程式名稱"}
