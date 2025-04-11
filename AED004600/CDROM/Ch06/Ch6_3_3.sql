USE master
GO
CREATE DATABASE 代理產品
ON PRIMARY
  ( NAME='代理產品',
    FILENAME= 'D:\Data\代理產品.mdf',
    SIZE=8MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB ),
FILEGROUP 代理產品_群組
  ( NAME = '代理產品_群組_11',
    FILENAME = 'D:\Data\代理產品_群組_11.ndf',
    SIZE = 2MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB ),
  ( NAME = '代理產品_群組_12',
    FILENAME = 'D:\Data\代理產品_群組_12.ndf',
    SIZE = 2MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB )
LOG ON
  ( NAME='代理產品_log',
    FILENAME = 'D:\Data\代理產品_log.ldf',
    SIZE=1MB,
    MAXSIZE=10MB,
    FILEGROWTH=10% )
