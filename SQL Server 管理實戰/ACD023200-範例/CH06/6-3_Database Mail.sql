
--範例程式碼6-4：使用系統預存程序：sp_configure，來啟用Database Mail功能
USE master
GO
--01 檢查是否有啟用 Database Mail
SELECT name N'組態選項的名稱', value N'針對這個選項所設定的值', value_in_use N'這個選項目前有效的執行值',  description N'組態選項的描述'  
FROM sys.configurations  
WHERE name='Database Mail XPs' 
GO

--02 設定啟用 Database Mail：使用 sp_configure 來啟用  Database Mail
EXEC sp_configure 'show advanced options',1
reconfigure
GO
-- 若要啟動，設定為 1。若要停止設定為 0
EXEC sp_configure 'Database Mail XPs',1
RECONFIGURE WITH OVERRIDE 




--範例程式碼6-5：查詢Database Mail相關設定

--查詢Database Mail設定檔
SELECT * FROM msdb.dbo.sysmail_profile
--查詢Database Mail帳戶
SELECT * FROM msdb.dbo.sysmail_account
--查詢設定檔對應的帳戶
select * from msdb.dbo.sysmail_profileaccount

--範例程式碼6-6：使用sp_send_dbmail系統預存程序傳送一封電子郵件

EXEC msdb.dbo.sp_send_dbmail 
@profile_name = 'DBA', --郵件設定檔名稱	
@recipients = 'Sandy@localhost.com',
@body = N'這是電子郵件訊息的主體',
@subject =N'這是電子郵件訊息的主旨。如果未指定主旨，預設值便是「SQL Server Message」。'



--範例程式碼6-7：使用sp_send_dbmail系統預存程序，搭配query參數

--將查詢結果以本文寄出
EXEC msdb.dbo.sp_send_dbmail
    @recipients = 'u99@localhost.com',
    @query = N'SELECT CompanyName 公司名稱,ContactName 聯絡人  
	FROM dbo.Customers
	WHERE Country=''Mexico''' 
  @subject = N'Mexico客戶';

--將查詢結果以附件寄出
EXEC msdb.dbo.sp_send_dbmail
    @recipients = 'u99@localhost.com',
    @query = N'SELECT CompanyName 公司名稱,ContactName 聯絡人 
	FROM dbo.Customers
	WHERE Country=''Mexico''' ,
    @execute_query_database='Northwind',
	@subject = N'Mexico客戶',
	@attach_query_result_as_file = 1 ,
	@query_attachment_filename='Mexico客戶清單.txt',
	@query_result_header=1 ;




--範例程式碼6-8：使用 sp_send_dbmail系統預存程序，設定使用HTML格式


-- 使用HTML格式來傳送電子郵件訊息
USE master
GO
DECLARE @m_recipients varchar(max), 
	@m_subject nvarchar(255), @m_body nvarchar(max),
	@m_body_format varchar(20)

SELECT @m_recipients = N'Byron@localhost.com',
	@m_subject = N'使用 Database Mail 傳送 HTML 格式的電子郵件訊息',
	@m_body =N'<p>輸入電子郵件訊息的主體內容：</p> 
             <font color="#0000ff"><strong>傳送 HTML 格式的電子郵件訊息</strong></font>',
	@m_body_format ='HTML'

EXEC msdb.dbo.sp_send_dbmail
	@recipients = @m_recipients,
	@subject = @m_subject,
	@body = @m_body,
	@body_format = @m_body_format



--範例程式碼6-9：使用 T-SQL陳述式整合HTML語法
/*
使用T-SQL陳述式整合HTML格式來傳送電子郵件訊息。
若是找不到資料時，會以空白的文字格式回傳
*/
USE Northwind
GO
DECLARE @m_recipients varchar(max), 
	@m_subject nvarchar(255), @m_body nvarchar(max),
	@m_body_format varchar(20)
	
SELECT @m_recipients = N'Byron@localhost.com',
	@m_subject = N'資料表明細，使用 HTML 格式',
	@m_body_format ='HTML',	
	@m_body = 
		N'<style>'+
		N'  table {   border:1px solid #000;   font-family: 微軟正黑體;   font-size:12px; '+
		+'border:1px solid #000;  border-collapse:collapse;} '+
		N' td {   border:1px solid #000;  padding:5px;} </style>'+
		N'<FONT COLOR="#800000"><H1>France客戶聯絡表</H1></FONT>' +
		N'<table border="2">' +
		N'<tr style="background-color:#9EC5D8"  ><th>公司名稱</th><th>聯絡人</th>' +
		N'<th>職稱</th><th>連絡電話</th>' +
		N'</tr>' +
		CAST ( ( SELECT    td = CompanyName ,       '',
						td = ContactName  ,       '',
						td = ContactTitle    ,       '',
						td = Phone   ,       ''						
				  FROM dbo.Customers Where Country='France'
				  ORDER BY  CompanyName
				  FOR XML PATH('tr'), TYPE 
		) AS NVARCHAR(MAX) ) +
		N'</table>' ;

EXEC msdb.dbo.sp_send_dbmail
	@recipients = @m_recipients,
	@subject = @m_subject,
	@body = @m_body,
	@body_format = @m_body_format



--範例程式碼6-10：呼叫sp_send_dbmail系統預存程序，以T-SQL陳述式整合HTML語法，加入判斷式，若找不到資料便回傳：無符合條件式的資料
/*
使用T-SQL陳述式整合HTML格式來傳送電子郵件訊息。
若是找不到資料時，會以空白的文字格式回傳
*/
USE Northwind
GO
CREATE OR ALTER PROC sp_sendCustomerMail @country varchar(20)
AS
DECLARE @m_recipients varchar(max), 
	@m_subject nvarchar(255), @m_body nvarchar(max),
	@m_body_format varchar(20)
IF not exists(SELECT * FROM dbo.Customers Where Country=@country )
	BEGIN
		SELECT @m_recipients = N'Byron@localhost.com',
			@m_subject = N'客戶聯絡表，使用 HTML 格式：無符合資料',
			@m_body = N'<p align="center"><font color="#ff0000" size="7"><strong>無符合條件式的資料</strong></font></p>',
			@m_body_format ='HTML';

		EXEC msdb.dbo.sp_send_dbmail
			@recipients = @m_recipients,
			@subject = @m_subject,
			@body = @m_body,
			@body_format = @m_body_format;
	END
ELSE
	BEGIN	
    SELECT @m_recipients = N'Byron@localhost.com',
	@m_subject = N'客戶聯絡表，使用 HTML 格式',
	@m_body_format ='HTML',	
	@m_body = 
		N'<style>'+
		N'  table {   border:1px solid #000;   font-family: 微軟正黑體;   font-size:12px; '+
		+'border:1px solid #000;  border-collapse:collapse;} '+
		N' td {   border:1px solid #000;  padding:5px;} </style>'+
		N'<FONT COLOR="#800000"><H1>'+@country+'客戶聯絡表</H1></FONT>' +
		N'<table border="2">' +
		N'<tr style="background-color:#9EC5D8"  ><th>公司名稱</th><th>聯絡人</th>' +
		N'<th>職稱</th><th>連絡電話</th>' +
		N'</tr>' +
		CAST ( ( SELECT    td = CompanyName ,       '',
						td = ContactName  ,       '',
						td = ContactTitle    ,       '',
						td = Phone   ,       ''						
				  FROM dbo.Customers Where Country=@country
				  ORDER BY  CompanyName
				  FOR XML PATH('tr'), TYPE 
		) AS NVARCHAR(MAX) ) +
		N'</table>' ;
	
	EXEC msdb.dbo.sp_send_dbmail
		@recipients = @m_recipients,
		@subject = @m_subject,
		@body = @m_body,
		@body_format = @m_body_format
END
GO

EXEC sp_sendCustomerMail 'Mexico2'
GO



--範例程式碼6-11：使用系統預存程序：sysmail_help_queue_sp檢視佇列中的資訊
EXEC msdb.dbo.sysmail_help_queue_sp;

--範例程式6.12：使用檢視：sysmail_event_log
SELECT * FROM msdb.dbo.sysmail_event_log ORDER BY log_id DESC

--範例程式碼6-13：使用檢視：sysmail_allitems

SELECT recipients,subject,body,send_request_user,sent_date,sent_status
FROM msdb.dbo.sysmail_allitems ORDER BY sent_date DESC

--範例程式碼6-14：使用系統預存程序：sysmail_delete_mailitems_sp

-- 會刪除 Database Mail 系統中的一個月以前的電子郵件。
DECLARE @Day datetime= DATEADD(MONTH,-1,CURRENT_TIMESTAMP)
EXECUTE msdb.dbo.sysmail_delete_mailitems_sp  @sent_before =@Day;
GO

/*@sent_status 的有效參數為：sent、unsent 和retrying */
-- 刪除已發送的郵件記錄
exec sysmail_delete_mailitems_sp @sent_status='sent'
-- 刪除未發送的郵件記錄
exec sysmail_delete_mailitems_sp @sent_status='unsent'
-- 刪除重試中的郵件記錄
exec sysmail_delete_mailitems_sp @sent_status='retrying'
-- 刪除發送失敗的郵件記錄
exec sysmail_delete_mailitems_sp @sent_status='failed'


--使用檢視表再度查詢電子郵件歷史記錄
SELECT * FROM msdb.dbo.sysmail_allitems



--範例程式碼6-15：使用系統預存程序：sysmail_delete_log_sp
--刪除1個月前的log資料
DECLARE @Day DATETIME=DATEADD(MONTH,-1,CURRENT_TIMESTAMP)
EXECUTE msdb.dbo.sysmail_delete_log_sp @logged_before = @Day


--刪除Database Mail記錄中的成工資訊
/*@event_type 的有效參數為：success、warning、error 和 information */
EXECUTE msdb.dbo.sysmail_delete_log_sp @event_type = 'success' ;  ;
GO
-- 刪除警示的記錄
EXECUTE msdb.sysmail_delete_log_sp @event_type = 'warning'
-- 刪除錯誤的記錄
EXECUTE msdb.sysmail_delete_log_sp @event_type = 'error'
-- 刪除資訊的記錄 
EXECUTE msdb.sysmail_delete_log_sp @event_type = 'information'
-- 刪除 Database Mail 記錄中的所有事件。
EXECUTE msdb.dbo.sysmail_delete_log_sp ;
GO
　
-- 再度檢視刪除後的記錄檔內容
SELECT * FROM msdb.dbo.sysmail_event_log 
