USE master
GO
ALTER DATABASE 產品 ADD LOG FILE
 ( NAME = '產品_log2',
   FILENAME = 'D:\Data\產品_log2.ldf',
   SIZE = 5MB,
   MAXSIZE=10MB,
   FILEGROWTH=1MB )

