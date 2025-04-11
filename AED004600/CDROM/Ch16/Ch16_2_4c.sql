USE 教務系統 
GO
CREATE VIEW 學生員工_檢視 AS
SELECT 學生.學號,學生.姓名,學生.性別, 
       學生.電話,學生.生日,
       員工.身份證字號,員工.城市,員工.街道,
       員工.薪水,員工.保險,員工.扣稅
FROM 學生 INNER JOIN 員工
ON 學生.姓名 = 員工.姓名
GO
SELECT * FROM 學生員工_檢視





