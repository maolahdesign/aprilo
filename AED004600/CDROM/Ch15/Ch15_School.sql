USE [master]
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name='教務系統')
DROP DATABASE [教務系統]
GO
/****** Object:  Database [教務系統]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE DATABASE [教務系統]
GO
USE [教務系統]
GO
/****** Object:  Sequence [dbo].[整數順序]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE SEQUENCE [dbo].[整數順序] 
 AS [int]
 START WITH 100
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  Table [dbo].[員工]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[員工](
	[身份證字號] [char](10) NOT NULL,
	[姓名] [varchar](12) NULL,
	[城市] [char](5) NULL,
	[街道] [varchar](30) NULL,
	[電話] [char](12) NULL,
	[薪水] [money] NULL,
	[保險] [money] NULL,
	[扣稅] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[身份證字號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[員工聯絡資料]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[員工聯絡資料]
AS
SELECT          TOP (100) PERCENT 身份證字號, 姓名, 城市, 街道, 電話
FROM              dbo.員工
ORDER BY   姓名
GO
/****** Object:  View [dbo].[高薪員工聯絡_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[高薪員工聯絡_檢視] 
WITH SCHEMABINDING
AS
SELECT 身份證字號, 姓名, 電話 FROM dbo.員工
WHERE 薪水 > 50000
GO
/****** Object:  Table [dbo].[班級]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[班級](
	[教授編號] [char](4) NOT NULL,
	[學號] [char](4) NOT NULL,
	[課程編號] [char](5) NOT NULL,
	[上課時間] [datetime] NULL,
	[教室] [varchar](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[教授編號] ASC,
	[課程編號] ASC,
	[學號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[教授]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[教授](
	[教授編號] [char](4) NOT NULL,
	[職稱] [varchar](10) NULL,
	[科系] [varchar](5) NULL,
	[身份證字號] [char](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[教授編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[課程]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[課程](
	[課程編號] [char](5) NOT NULL,
	[名稱] [varchar](30) NULL,
	[學分] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[課程編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[學生]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[學生](
	[學號] [char](4) NOT NULL,
	[姓名] [varchar](12) NOT NULL,
	[性別] [char](2) NULL,
	[電話] [varchar](15) NULL,
	[生日] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[學號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[學生_班級_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[學生_班級_檢視] AS
SELECT 學生.學號, 學生.姓名, 課程.*, 教授.*
FROM 教授 INNER JOIN
(課程 INNER JOIN 
(學生 INNER JOIN 班級 ON 學生.學號 = 班級.學號) 
ON 班級.課程編號 = 課程.課程編號) 
ON 班級.教授編號 = 教授.教授編號
GO
/****** Object:  View [dbo].[學分_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[學分_檢視] AS
SELECT 學生.學號, COUNT(*) AS 修課數, 
       SUM(課程.學分) AS 學分數
FROM 學生, 課程, 班級 
WHERE 學生.學號 = 班級.學號
  AND 課程.課程編號 = 班級.課程編號 
GROUP BY 學生.學號
GO
/****** Object:  View [dbo].[學生_學分_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[學生_學分_檢視] AS
SELECT 學分_檢視.*, 學生.姓名, 學生.電話 
FROM 學生, 學分_檢視 
WHERE 學生.學號 = 學分_檢視.學號
GO
/****** Object:  View [dbo].[生日_檢視_有主鍵]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[生日_檢視_有主鍵] AS
SELECT 學號, 姓名, 生日 FROM 學生 
WITH CHECK OPTION
GO
/****** Object:  View [dbo].[生日_檢視_沒有主鍵]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[生日_檢視_沒有主鍵] AS
SELECT 姓名, 生日 FROM 學生 
WITH CHECK OPTION
GO
/****** Object:  View [dbo].[高學分_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[高學分_檢視] AS
SELECT 學生.學號, COUNT(*) AS 修課數, 
       SUM(課程.學分) AS 學分數
FROM 學生, 課程, 班級 
WHERE 學生.學號 = 班級.學號
  AND 課程.課程編號 = 班級.課程編號 
GROUP BY 學生.學號
HAVING SUM(課程.學分) >= 7
GO
/****** Object:  View [dbo].[高薪員工_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[高薪員工_檢視]
AS
SELECT * FROM 員工
WHERE 薪水 > 50000
GO
/****** Object:  View [dbo].[學生上課教室_檢視]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[學生上課教室_檢視]
WITH SCHEMABINDING
AS
SELECT 學生.學號, 班級.教室,COUNT_BIG(*) AS 上課數
FROM dbo.學生 INNER JOIN dbo.班級 
ON 學生.學號 = 班級.學號
GROUP BY 學生.學號, 班級.教室
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [上課報表_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE UNIQUE CLUSTERED INDEX [上課報表_索引] ON [dbo].[學生上課教室_檢視]
(
	[學號] ASC,
	[教室] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[好客戶]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[好客戶](
	[客戶編號] [int] IDENTITY(1,1) NOT NULL,
	[身份證字號] [char](10) NOT NULL,
	[姓名] [varchar](12) NOT NULL,
	[電話] [char](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[客戶編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[好員工]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[好員工](
	[員工編號] [int] IDENTITY(1,1) NOT NULL,
	[姓名] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[員工編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[估價單]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[估價單](
	[估價單編號] [int] IDENTITY(1,1) NOT NULL,
	[產品編號] [char](4) NOT NULL,
	[總價] [decimal](5, 1) NOT NULL,
	[數量] [int] NOT NULL,
	[平均單價]  AS ([總價]/[數量]),
PRIMARY KEY CLUSTERED 
(
	[估價單編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[廠商名單]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[廠商名單](
	[廠商編號] [int] IDENTITY(1,1) NOT NULL,
	[廠商名稱] [varchar](100) NULL,
	[廠商類型] [tinyint] NOT NULL,
	[分公司數] [int] SPARSE  NULL,
PRIMARY KEY CLUSTERED 
(
	[廠商編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[熱銷產品]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[熱銷產品](
	[產品編號] [char](5) NOT NULL,
	[產品名稱] [varchar](30) NULL,
	[定價] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[產品編號] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[課程備份]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[課程備份](
	[課程編號] [char](5) NOT NULL,
	[名稱] [varchar](30) NULL,
	[學分] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[課程備份2]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[課程備份2](
	[課程編號] [char](5) NOT NULL,
	[名稱] [varchar](30) NULL,
	[學分] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[學生備份]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[學生備份](
	[學號] [char](4) NOT NULL,
	[姓名] [varchar](12) NOT NULL,
	[性別] [char](2) NULL,
	[電話] [varchar](15) NULL,
	[生日] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[學生備份2]    Script Date: 2023/1/2 下午 02:25:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[學生備份2](
	[學號] [char](4) NOT NULL,
	[姓名] [varchar](12) NOT NULL,
	[性別] [char](2) NULL,
	[電話] [varchar](15) NULL,
	[生日] [date] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[好客戶] ON 

INSERT [dbo].[好客戶] ([客戶編號], [身份證字號], [姓名], [電話]) VALUES (1, N'A333333333', N'王大安', NULL)
SET IDENTITY_INSERT [dbo].[好客戶] OFF
GO
SET IDENTITY_INSERT [dbo].[好員工] ON 

INSERT [dbo].[好員工] ([員工編號], [姓名]) VALUES (2, N'王允傑')
INSERT [dbo].[好員工] ([員工編號], [姓名]) VALUES (3, N'陳允傑')
SET IDENTITY_INSERT [dbo].[好員工] OFF
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A123456789', N'陳慶新', N'台北 ', N'信義路', N'02-11111111 ', 80000.0000, 5000.0000, 2000.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A221304680', N'郭富城', N'台北 ', N'忠孝東路', N'02-55555555 ', 35000.0000, 1000.0000, 800.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A222222222', N'楊金欉', N'桃園 ', N'中正路', N'03-11111111 ', 80000.0000, 4500.0000, 2000.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'D333300333', N'王心零', N'桃園 ', N'經國路', NULL, 50000.0000, 2500.0000, 1000.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'D444403333', N'劉得華', N'新北 ', N'板橋區文心路', N'04-55555555 ', 25000.0000, 500.0000, 500.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'E444006666', N'小龍女', N'新北 ', N'板橋區中正路', N'04-55555555 ', 25000.0000, 500.0000, 500.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'F213456780', N'陳小安', N'新北 ', N'新店區四維路', NULL, 50000.0000, 3000.0000, 1000.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'F332213046', N'張無忌', N'台北 ', N'仁愛路', N'02-55555555 ', 50000.0000, 1500.0000, 1000.0000)
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'H098765432', N'李鴻章', N'基隆 ', N'信四路', N'02-33111111 ', 60000.0000, 4000.0000, 1500.0000)
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S001', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S005', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S006', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S003', N'CS213', CAST(N'1900-01-01T09:00:00.000' AS DateTime), N'622-G')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S005', N'CS213', CAST(N'1900-01-01T09:00:00.000' AS DateTime), N'622-G')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S001', N'CS349', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'380-L')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S003', N'CS349', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'380-L')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S003', N'CS121', CAST(N'1900-01-01T08:00:00.000' AS DateTime), N'221-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S008', N'CS121', CAST(N'1900-01-01T08:00:00.000' AS DateTime), N'221-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S001', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S002', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S004', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S001', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S002', N'CS203', CAST(N'1900-01-01T14:00:00.000' AS DateTime), N'327-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S006', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S008', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S001', N'CS213', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'500-K')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S006', N'CS213', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'500-K')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S002', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S003', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S005', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
GO
INSERT [dbo].[教授] ([教授編號], [職稱], [科系], [身份證字號]) VALUES (N'I001', N'教授', N'CS', N'A123456789')
INSERT [dbo].[教授] ([教授編號], [職稱], [科系], [身份證字號]) VALUES (N'I002', N'教授', N'CS', N'A222222222')
INSERT [dbo].[教授] ([教授編號], [職稱], [科系], [身份證字號]) VALUES (N'I003', N'副教授', N'CIS', N'H098765432')
INSERT [dbo].[教授] ([教授編號], [職稱], [科系], [身份證字號]) VALUES (N'I004', N'講師', N'MATH', N'F213456780')
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS349', N'物件導向分析', 3)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS213', N'物件導向程式設計', 2)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS101', N'計算機概論', 4)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS203', N'程式語言', 3)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS222', N'資料庫管理系統', 3)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS205', N'網頁程式設計', 3)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS111', N'線性代數', 4)
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS121', N'離散數學', 4)
GO
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS349', N'物件導向分析', 3)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS213', N'物件導向程式設計', 2)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS101', N'計算機概論', 4)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS203', N'程式語言', 3)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS222', N'資料庫管理系統', 3)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS205', N'網頁程式設計', 3)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS111', N'線性代數', 4)
INSERT [dbo].[課程備份] ([課程編號], [名稱], [學分]) VALUES (N'CS121', N'離散數學', 4)
GO
INSERT [dbo].[課程備份2] ([課程編號], [名稱], [學分]) VALUES (N'CS349', N'物件導向分析', 3)
INSERT [dbo].[課程備份2] ([課程編號], [名稱], [學分]) VALUES (N'CS203', N'程式語言', 3)
INSERT [dbo].[課程備份2] ([課程編號], [名稱], [學分]) VALUES (N'CS222', N'資料庫管理系統', 3)
INSERT [dbo].[課程備份2] ([課程編號], [名稱], [學分]) VALUES (N'CS205', N'網頁程式設計', 3)
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S001', N'陳會安', N'男', N'02-22222222', CAST(N'2003-09-03' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S002', N'江小魚', N'女', N'03-33333333', CAST(N'2004-02-02' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S003', N'張無忌', N'男', N'04-44444444', CAST(N'2002-05-03' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S004', N'陳小安', N'男', N'05-55555555', CAST(N'2002-06-13' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S005', N'孫燕之', N'女', N'06-66666666', NULL)
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S006', N'周杰輪', N'男', N'02-33333333', CAST(N'2003-12-23' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S007', N'蔡一零', N'女', N'03-66666666', CAST(N'2003-11-23' AS Date))
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S008', N'劉得華', N'男', N'02-11111122', CAST(N'2003-02-23' AS Date))
GO
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S001', N'陳會安', N'男', N'02-22222222', CAST(N'2003-09-03' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S002', N'江小魚', N'女', N'03-33333333', CAST(N'2004-02-02' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S003', N'張無忌', N'男', N'04-44444444', CAST(N'2002-05-03' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S004', N'陳小安', N'男', N'05-55555555', CAST(N'2002-06-13' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S005', N'孫燕之', N'女', N'06-66666666', NULL)
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S006', N'周杰輪', N'男', N'02-33333333', CAST(N'2003-12-23' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S007', N'蔡一零', N'女', N'03-66666666', CAST(N'2003-11-23' AS Date))
INSERT [dbo].[學生備份] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S008', N'劉得華', N'男', N'02-11111122', CAST(N'2003-02-23' AS Date))
GO
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S001', N'陳會安', N'男', N'02-22222222', CAST(N'2003-09-03' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S002', N'江小魚', N'女', N'03-33333333', CAST(N'2004-02-02' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S003', N'張無忌', N'男', N'04-44444444', CAST(N'2002-05-03' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S004', N'陳小安', N'男', N'05-55555555', CAST(N'2002-06-13' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S005', N'孫燕之', N'女', N'06-66666666', NULL)
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S006', N'周杰輪', N'男', N'02-33333333', CAST(N'2003-12-23' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S007', N'蔡一零', N'女', N'03-66666666', CAST(N'2003-11-23' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S008', N'劉得華', N'男', N'02-11111122', CAST(N'2003-02-23' AS Date))
INSERT [dbo].[學生備份2] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S118', N'王沖', N'男', N'02-23333322', CAST(N'2002-05-13' AS Date))
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [平均單價_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE NONCLUSTERED INDEX [平均單價_索引] ON [dbo].[估價單]
(
	[平均單價] ASC
)
INCLUDE([產品編號]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [分公司數_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE NONCLUSTERED INDEX [分公司數_索引] ON [dbo].[廠商名單]
(
	[分公司數] ASC
)
WHERE ([廠商類型]=(3))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__熱銷產品__67EB3F6257F4B3F3]    Script Date: 2023/1/2 下午 02:25:42 ******/
ALTER TABLE [dbo].[熱銷產品] ADD UNIQUE NONCLUSTERED 
(
	[產品名稱] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [名稱學分_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE UNIQUE NONCLUSTERED INDEX [名稱學分_索引] ON [dbo].[課程]
(
	[名稱] ASC,
	[學分] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [姓名_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE UNIQUE NONCLUSTERED INDEX [姓名_索引] ON [dbo].[學生]
(
	[姓名] ASC
)
INCLUDE([電話],[生日]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [教室_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE NONCLUSTERED INDEX [教室_索引] ON [dbo].[學生上課教室_檢視]
(
	[教室] ASC
)
INCLUDE([學號],[上課數]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredColumnStoreIndex-20221231-095252]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE NONCLUSTERED COLUMNSTORE INDEX [NonClusteredColumnStoreIndex-20221231-095252] ON [dbo].[課程備份]
(
	[名稱],
	[學分]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
GO
/****** Object:  Index [學生資料行_索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE NONCLUSTERED COLUMNSTORE INDEX [學生資料行_索引] ON [dbo].[學生備份]
(
	[姓名],
	[生日],
	[電話]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
GO
/****** Object:  Index [ClusteredColumnStoreIndex-20221231-095829]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [ClusteredColumnStoreIndex-20221231-095829] ON [dbo].[課程備份2] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
GO
/****** Object:  Index [學生資料行_叢集索引]    Script Date: 2023/1/2 下午 02:25:42 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [學生資料行_叢集索引] ON [dbo].[學生備份2] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
GO
ALTER TABLE [dbo].[估價單] ADD  DEFAULT ((1)) FOR [數量]
GO
ALTER TABLE [dbo].[班級]  WITH CHECK ADD FOREIGN KEY([教授編號])
REFERENCES [dbo].[教授] ([教授編號])
GO
ALTER TABLE [dbo].[班級]  WITH CHECK ADD FOREIGN KEY([課程編號])
REFERENCES [dbo].[課程] ([課程編號])
GO
ALTER TABLE [dbo].[班級]  WITH CHECK ADD FOREIGN KEY([學號])
REFERENCES [dbo].[學生] ([學號])
GO
ALTER TABLE [dbo].[教授]  WITH CHECK ADD FOREIGN KEY([身份證字號])
REFERENCES [dbo].[員工] ([身份證字號])
GO
/****** Object:  StoredProcedure [dbo].[地址查詢]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[地址查詢]
   @city char(5) = '台北',
   @street varchar(30) = '中正路'
AS
BEGIN
  SELECT 身份證字號, 姓名, 
      (薪水-扣稅) AS 所得額, 
      (城市+街道) AS 地址
  FROM 員工
  WHERE 城市 LIKE @city
    AND 街道 LIKE @street
END

GO
/****** Object:  StoredProcedure [dbo].[呼叫程序]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[呼叫程序]
   @proc_name varchar(30)
AS
PRINT '開始層數: ' + CAST(@@NESTLEVEL AS char)
EXEC @proc_name
PRINT '結束層數: ' + CAST(@@NESTLEVEL AS char)
GO
/****** Object:  StoredProcedure [dbo].[員工查詢]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[員工查詢]
   @salary money,
   @tax    money
AS
BEGIN
  IF @salary <= 0
     SET @salary = 30000
  IF @tax <= 0
     SET @tax = 300
  SELECT 身份證字號, 姓名, 
      (薪水-扣稅) AS 所得額
  FROM 員工
  WHERE 薪水 >= @salary
    AND 扣稅 >= @tax
END
GO
/****** Object:  StoredProcedure [dbo].[測試程序]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[測試程序]
AS
PRINT '層數: ' + CAST(@@NESTLEVEL AS char)

GO
/****** Object:  StoredProcedure [dbo].[新增課程]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[新增課程]
   @c_no char(5),
   @title  varchar(30),
   @credits int
AS
BEGIN
  DECLARE @errorNo int
  INSERT INTO 課程 
  VALUES (@c_no, @title, @credits)
  SET @errorNo = @@ERROR
  IF @errorNo <> 0
  BEGIN
    IF @errorNo = 2627
       PRINT '錯誤! 重複索引鍵!'
    ELSE
       PRINT '錯誤! 未知錯誤發生!'
    RETURN @errorNO
  END
END

GO
/****** Object:  StoredProcedure [dbo].[課程查詢]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[課程查詢]
   @c_no char(5)
AS
BEGIN
  SELECT 課程編號, 名稱, 學分
  FROM 課程
  WHERE 課程編號 = @c_no
END
GO
/****** Object:  StoredProcedure [dbo].[學生上課報表]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[學生上課報表] AS
BEGIN
  SELECT 學生.學號, 學生.姓名, 課程.*, 教授.*
  FROM 教授 INNER JOIN
  (課程 INNER JOIN 
  (學生 INNER JOIN 班級 ON 學生.學號 = 班級.學號) 
  ON 班級.課程編號 = 課程.課程編號) 
  ON 班級.教授編號 = 教授.教授編號
END


GO
/****** Object:  StoredProcedure [dbo].[薪水查詢]    Script Date: 2023/1/2 下午 02:25:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[薪水查詢]
   @name  varchar(12),
   @salary  money  OUTPUT
AS
BEGIN
  SELECT @salary = 薪水
  FROM 員工
  WHERE 姓名 = @name
END
GO
USE [master]
GO
ALTER DATABASE [教務系統] SET  READ_WRITE 
GO
