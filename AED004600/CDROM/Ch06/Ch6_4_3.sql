USE master
GO
ALTER DATABASE 產品 ADD FILE
(  NAME = '產品_群組_13',
   FILENAME = 'D:\Data\產品_群組_13.ndf',
   SIZE = 2MB,
   MAXSIZE=10MB,
   FILEGROWTH=1MB ) TO FILEGROUP 產品_群組

