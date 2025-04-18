#04FunctionDemo.ps1
# 紀錄錯誤
Function log_This(
[string]$logApp,
[string]$logMsg)
{
      $log = New-Object System.Diagnostics.EventLog('Application') 
      $log.set_source($logApp)
      Write-Host $logMsg
      $log.WriteEntry($logMsg)
}

# 透過$error公共變數呈現錯誤
Function handle_This (
[string]$appName)
 {
      # 建立錯誤訊息字串
      $log_Message = "Error Category: " + $error[0].CategoryInfo.Category 
      $log_Message = $log_Message + ". 執行的物件：" + $error[0].TargetObject 
      $log_Message = $log_Message + " 錯誤訊息：" + $error[0].Exception.Message 
      $log_Message = $log_Message + " 錯誤訊息： " + $error[0].FullyQualifiedErrorId 
      Write-Host $log_Message
      write-Host "錯誤發生於 " $appName "檢查事件紀錄，以取得更多資訊"
	
      # 自動傳送訊息給先前撰寫的 Logging 函數：
      log_This $appName $log_Message
}

# 錯誤處理範例，執行某項工作
Function ErrorHappensHere
{ 
      SomeFun #沒有這個指令或函數，所以發生錯誤
      Trap {
            # 透過Trap集中錯誤處理，若要結構化錯誤處理，可以採用 try catch
            handle_This("SomeFun")
            # 若發生錯誤後，就停下來，可以使用 break
            # break;
            # 或是繼續進行
            continue;
            }
}

# 呼叫上述會發生錯誤的函數
ErrorHappensHere

write-Host "檢查事件紀錄"
# 呈現上述測試PowerShell寫入的Windows事件紀錄
get-Eventlog application | where-Object {$_.Source -like "SomeFun*"} 
write-Host "完成錯誤輸出"

# 透過電子郵件寄發訊息
Function mail_This ($mail_From, $mail_To, $mail_Subject, $mail_Body, $mail_Attachment)
{
      # 簡易的電子郵件設定
      # $smtp = new-object Net.Mail.SmtpClient("localhost") 
      # $smtp.Send($mail_From, $mail_To, $mail_Subject, $mail_Body)

      $smtpServer = "localhost" 
      $msg = new-object Net.Mail.MailMessage
      $att = new-object Net.Mail.Attachment([string]$mail_Attachment)
      $smtp = new-object Net.Mail.SmtpClient $smtpServer 
      $msg.From =$mail_From
      $msg.To.Add($mail_To)
      $msg.Subject = $mail_Subject
      $msg.Body = $mail_Body
      $msg.Attachments.Add($att) 
      $smtp.Send($msg)
} 
mail_This "PowerShell@sql2022" "Someone@sql2022" "來自 PowerShell 的通知" "測試從 PowerShell 發送電子郵件" 'C:\BookSamples\SQL2022Management\Chap16\myLog.log'
#需在本機啟用 SMTP 伺服器功能，並授與本機可透過 SMTP 虛擬伺服器轉送郵l件之權限


# System Tray "Balloons"
Function balloon_This ($objNotifyIcon, $balloon_Title, $balloon_Text)
{
      $objNotifyIcon.Icon =  'C:\BookSamples\SQL2022Management\Chap16\Info.ICO'
      $objNotifyIcon.BalloonTipIcon = 'Info'
      # Info, Warning, Error 
      $objNotifyIcon.BalloonTipTitle = $balloon_Title
      $objNotifyIcon.BalloonTipText = $balloon_Text 
      $objNotifyIcon.Visible = $True 
      $objNotifyIcon.ShowBalloonTip(10000)

 }

 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 $objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon 
 #若要讓 NotifyIcon 物件的 click 事件能觸發執行，則物件不能隨函數結束就消失
 #所以建立物件需要在外面的 Script 區塊
 #以下兩者都是PowerShell註冊物件的事件處理函數的方式
 $objNotifyIcon.add_Click({$objNotifyIcon.Dispose()})
 #Register-ObjectEvent -InputObject $objNotifyIcon -EventName Click -Action {$objNotifyIcon.Dispose()}

 balloon_This $objNotifyIcon '注意！！' '要開始做些事情。事情進行時，可以透過此傳送些訊息'


# 轉成 HTML 檔案輸出
Function web_This ($web_Title)
{
      # 以 CSS styles 當作 HTML Header
      $formatHTML = "<style>"
      $formatHTML = $formatHTML + "BODY{background-color:white;color:black}"
      $formatHTML = $formatHTML + "TABLE{border-width: 1px;border-style: solid;border-color: blue;border-collapse: collapse;}"
      $formatHTML = $formatHTML + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:white}"
      $formatHTML = $formatHTML + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:white}"
      $formatHTML = $formatHTML + "</style>"
      # 將系統當下執行的 Process 狀態以 HTML 格式輸出 
      Get-Process | ConvertTo-Html -head $formatHTML –title $web_Title | Out-File "C:\BookSamples\SQL2022Management\Chap16\$web_Title.htm"
      #產生 HTML 後，再叫起來這份網頁
      ."C:\BookSamples\SQL2022Management\Chap16\$web_Title.htm"
}
web_This "ProcessDetail"
