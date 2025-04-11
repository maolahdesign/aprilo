USE [教務系統]
GO
/****** Object:  Table [dbo].[員工]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
/****** Object:  View [dbo].[員工聯絡資料]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
/****** Object:  Table [dbo].[班級]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
/****** Object:  Table [dbo].[課程]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
/****** Object:  Table [dbo].[學生]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
/****** Object:  View [dbo].[高學分_檢視]    Script Date: 2022/12/31 下午 12:48:05 ******/
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
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A123456789', N'陳慶新', N'台北 ', N'信義路', N'02-11111111 ', 80000.0000, 5000.0000, 2000.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A221304680', N'郭富城', N'台北 ', N'忠孝東路', N'02-55555555 ', 35000.0000, 1000.0000, 800.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'A222222222', N'楊金欉', N'桃園 ', N'中正路', N'03-11111111 ', 80000.0000, 4500.0000, 2000.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'D333300333', N'王心零', N'桃園 ', N'經國路', NULL, 50000.0000, 2500.0000, 1000.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'D444403333', N'劉得華', N'新北 ', N'板橋區文心路', N'04-55555555 ', 25000.0000, 500.0000, 500.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'E444006666', N'小龍女', N'新北 ', N'板橋區中正路', N'04-55555555 ', 25000.0000, 500.0000, 500.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'F213456780', N'陳小安', N'新北 ', N'新店區四維路', NULL, 50000.0000, 3000.0000, 1000.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'F332213046', N'張無忌', N'台北 ', N'仁愛路', N'02-55555555 ', 50000.0000, 1500.0000, 1000.0000)
GO
INSERT [dbo].[員工] ([身份證字號], [姓名], [城市], [街道], [電話], [薪水], [保險], [扣稅]) VALUES (N'H098765432', N'李鴻章', N'基隆 ', N'信四路', N'02-33111111 ', 60000.0000, 4000.0000, 1500.0000)
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S001', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S005', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S006', N'CS101', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'180-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S003', N'CS213', CAST(N'1900-01-01T09:00:00.000' AS DateTime), N'622-G')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S005', N'CS213', CAST(N'1900-01-01T09:00:00.000' AS DateTime), N'622-G')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S001', N'CS349', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'380-L')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I001', N'S003', N'CS349', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'380-L')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S003', N'CS121', CAST(N'1900-01-01T08:00:00.000' AS DateTime), N'221-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S008', N'CS121', CAST(N'1900-01-01T08:00:00.000' AS DateTime), N'221-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S001', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S002', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I002', N'S004', N'CS222', CAST(N'1900-01-01T13:00:00.000' AS DateTime), N'100-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S001', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S002', N'CS203', CAST(N'1900-01-01T14:00:00.000' AS DateTime), N'327-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S006', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S008', N'CS203', CAST(N'1900-01-01T10:00:00.000' AS DateTime), N'221-S')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S001', N'CS213', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'500-K')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I003', N'S006', N'CS213', CAST(N'1900-01-01T12:00:00.000' AS DateTime), N'500-K')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S002', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S003', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
GO
INSERT [dbo].[班級] ([教授編號], [學號], [課程編號], [上課時間], [教室]) VALUES (N'I004', N'S005', N'CS111', CAST(N'1900-01-01T15:00:00.000' AS DateTime), N'321-M')
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS349', N'物件導向分析', 3)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS213', N'物件導向程式設計', 2)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS101', N'計算機概論', 4)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS203', N'程式語言', 3)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS222', N'資料庫管理系統', 3)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS205', N'網頁程式設計', 3)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS111', N'線性代數', 4)
GO
INSERT [dbo].[課程] ([課程編號], [名稱], [學分]) VALUES (N'CS121', N'離散數學', 4)
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S001', N'陳會安', N'男', N'02-22222222', CAST(N'2003-09-03' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S002', N'江小魚', N'女', N'03-33333333', CAST(N'2004-02-02' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S003', N'張無忌', N'男', N'04-44444444', CAST(N'2002-05-03' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S004', N'陳小安', N'男', N'05-55555555', CAST(N'2002-06-13' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S005', N'孫燕之', N'女', N'06-66666666', NULL)
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S006', N'周杰輪', N'男', N'02-33333333', CAST(N'2003-12-23' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S007', N'蔡一零', N'女', N'03-66666666', CAST(N'2003-11-23' AS Date))
GO
INSERT [dbo].[學生] ([學號], [姓名], [性別], [電話], [生日]) VALUES (N'S008', N'劉得華', N'男', N'02-11111122', CAST(N'2003-02-23' AS Date))
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
