USE 教務系統 
GO
SET ANSI_NULLS, ANSI_PADDING,
    ANSI_WARNINGS, ARITHABORT,
    CONCAT_NULL_YIELDS_NULL,
    QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
GO
CREATE VIEW dbo.學生上課教室_檢視
WITH SCHEMABINDING
AS
SELECT 學生.學號, 班級.教室,COUNT_BIG(*) AS 上課數
FROM dbo.學生 INNER JOIN dbo.班級 
ON 學生.學號 = 班級.學號
GROUP BY 學生.學號, 班級.教室
GO 
SELECT * FROM 學生上課教室_檢視





















 































































