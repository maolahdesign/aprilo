USE 教務系統 
GO
EXEC sp_addmessage 55555, 5 ,'Error! grade < 0!', 
       @lang = 'us_english'
GO
EXEC sp_addmessage 55555, 5 ,'成績為負數的錯誤!', 
       @lang = '繁體中文'






























































