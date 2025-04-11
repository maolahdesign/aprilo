CREATE DATABASE [聯絡人]
GO
USE [聯絡人]
GO
CREATE TABLE [聯絡資料]
(
	[編號] char(4) NOT NULL,
	[姓名] varchar(12) NOT NULL,
	[性別] char(2) NULL,
	[電話] varchar(15) NULL,
	[生日] datetime NULL,
PRIMARY KEY ([編號])
) 
GO
