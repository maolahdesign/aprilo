USE master
GO
CREATE DATABASE 教務系統
ON PRIMARY
  ( NAME='教務系統',
    FILENAME= 'D:\Data\教務系統.mdf',
    SIZE=8MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB ),
FILEGROUP 教務系統_群組
  ( NAME = '教務系統_群組_11',
    FILENAME = 'D:\Data\教務系統_群組_11.ndf',
    SIZE = 2MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB ),
  ( NAME = '教務系統_群組_12',
    FILENAME = 'D:\Data\教務系統_群組_12.ndf',
    SIZE = 2MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB )
LOG ON
  ( NAME='教務系統_log',
    FILENAME = 'D:\Data\教務系統_log.ldf',
    SIZE=1MB,
    MAXSIZE=10MB,
    FILEGROWTH=10% )
