USE 教務系統 
GO
SET ANSI_NULLS, ANSI_PADDING,
    ANSI_WARNINGS, ARITHABORT,
    CONCAT_NULL_YIELDS_NULL,
    QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
GO
CREATE NONCLUSTERED INDEX 教室_索引 
ON 學生上課教室_檢視(教室)
INCLUDE (學號, 上課數)
 

















 































































