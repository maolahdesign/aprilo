Function WriteFile($Msg)
{
      $sw = New-Object System.IO.StreamWriter 'C:\BookSamples\SQL2022Management\Chap16\myLog.log',True 
      $sw.WriteLine($Msg)
      $sw.Close()
}

#測試呼叫函數
WriteFile('Hello Msg')

#呈現記錄檔內容
gc C:\BookSamples\SQL2022Management\Chap16\myLog.log 
